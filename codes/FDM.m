%% FDM minseok has made


h=0.2;
x=0:h:5;
y=0:h:5;
n=5/h+1;

%h=dx=dy
A=eye(n*n);
%x axis boundary
for i=n+1:n*n-n
    A(i,[i-n i-1 i i+1 i+n])=[-1 -1 4 -1 -1];
end

%y axis boundary
for i=n+1:n:n*n-2*n+1
    A(i,[i-n i-1 i i+1 i+n])=[0 0 1 0 0];
    A(i+n-1,[i-1 i+n-2 i+n-1 i+n i+2*n-1])=[0 0 1 0 0];
end

%boundary condition xf1,xf2,fxf3,xf4
%xf(1)=-sin((pi).*y)-y
%xf(2)=sin((pi).*y)-y+5
%xf(3)=sin((pi).*y)+y
%xf(4)=-sin((pi).*y)+y-5
%domain is [0,5]*[0,5]
%poisson equation f(x) is 'fun' = 2*(pi)^2*sin((pi).*(x-y))
%exact solution is sin((pi)*(x-y))+5x-5y
B=zeros(n^2,1);
B(1:n)=xf1(y);
B(n^2-n+1:n^2)=xf2(y); 
for i=2:n-1
    B(1+n*(i-1):n*i)=fun(x(i),y).*(h^2);
end

for i=2:n-1
    B(i*n-n+1)=xf3(x(i));
    B(i*n)=xf4(x(i));
end



C=A\B;
U=zeros(n,n);

for i=1:n
    U(1:n,i)=C(n*(i-1)+1:n*i);
end

%v is exact solution, compare U and v!
for i=1:n
    for j=1:n
        v(i,j)=sin((pi)*(x(j)-y(i)))+x(j)-y(i);
    end
end

surf(x,y,U)
