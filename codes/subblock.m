%% 완료. % 하지만 block size=2의 거듭제곱 형태로 한정임.
%% block size를 내가 설정했을 때, 마지막에 남은 block은 기존의 것들 보다 작을 수 있음
%% 이 경우 기존의 block size와 같아질 때까지 0으로 padding을 함(A는 RESIDUE BLOCK만 padding, B는 전체적으로 padding)

%% FDM으로 BAND MATRIX 만들기
% n=4095; 
% % building up the matrix form
% d = ones(n+1,1);
% d0 = d*-4;
% A = spdiags([d0,d,d,d,d,d,d], [0, 1, -1, 2, -2, 3, -3], n+1, n+1);
% A = full(A);

%% bandwidth = y ( = #diagonal) 계산
[i,j] = find(A);
y = 2*max(i-j) + 1;

%% A size 계산 
m=size(A);
m=m(1);

%% block size=x 계산
for i=1:y
    if ((2^(i-1)+2<=y) & (y<=2^i+1)) == 1
        x=2^i;
        break;
    end
end
x=16


%% 겹치는 matrix size=b
b=x/2;

%% (block 개수)=a 계산 (이건 사이즈가 같은 block 개수로 총 block의 개수는 a+1이다)
a=1;
for j=2:floor(m/(x/2))
    if x*(j-1)/2+x<m
        a=j;
    else
        break;
    end
end
X=x*(a-1)/2+x;

%% a개의 block 쪼개 cell로 저장
D1=cell(1,a);

for i=1:a
    D1{i}=mat2cell(A((i-1)*(x-b)+1:i*x-(i-1)*b,(i-1)*(x-b)+1:i*x-(i-1)*b), [x/2 x/2], [x/2 x/2]);
end

A_RES=zeros(x);
A_RES(1:m-x*(a-2)/2-x, 1:m-x*(a-2)/2-x)=A(x*(a-2)/2+x+1:m, x*(a-2)/2+x+1:m);
D1{a+1}=mat2cell(A_RES, [x/2 x/2], [x/2 x/2]);

%% 부족한 개수만큼 padding 한 BB 만들기
B=A+1;
BB=zeros(2*m-a*x+(a-1)*b); 
BB(1:m, 1:m)=B;

%% B를 A의 subblock size로 쪼개어 BB1를 생성 후, C계산
BB1_array = ones(1,length(BB)/(x/2))*(x/2);

BB1 = cell(1,length(BB)/(x/2)); % a+1=length(B)/(x/2)임!!

for j=1:length(BB)/(x/2)
    BB1{j} = mat2cell(BB(x*(j-1)/2+1:x*j/2,:), x/2, BB1_array);
end

%% C 계산(i=1 & i=a+1일 때는 따로 계산/나머지는 for문으로 계산)
tic
C=zeros(m);
for j=1:length(BB)/(x/2)
    C(1:x/2, x*(j-1)/2+1:x*j/2)=strass(D1{1}{1,1}, BB1{1}{j}) + strass(D1{1}{1, 2}, BB1{2}{j});
end

for i=2:a+1 % i=a+1일때는 residue block 총 2열 중 1열 계산식임
    for j=1:length(BB)/(x/2)
        C(x*(i-1)/2+1:x*i/2, x*(j-1)/2+1:x*j/2)=strass(D1{i-1}{2,1}, BB1{i-1}{j}) + strass(D1{i}{1,1}, BB1{i}{j}) + strass(D1{i}{1,2}, BB1{i+1}{j});
    end
end

% RESIDUE BLOCK 총 2열 중 2열 계산( D1{a+1}{2,1} & D1{a+1}{2,2} )
for j=1:length(BB)/(x/2)
    C(x*(a+1)/2+1:x*(a+2)/2, x*(j-1)/2+1:x*j/2)=strass(D1{a+1}{2,1}, BB1{a+1}{j}) + strass(D1{a+1}{2, 2}, BB1{a+2}{j});
end

C=C(1:m,1:m);
toc

REALC=A*B;
isequal(C, REALC)
