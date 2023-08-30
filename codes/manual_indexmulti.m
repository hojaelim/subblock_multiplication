% This script is for finding the product of multiplication between a
% sparse matrix A and a dense matrix B, by finding the nonzero indicies
% from A and multiplying them to the corresponding indices in B.

%% Define dimensions
dim = size(A);
inC = zeros(dim(1),dim(2));

%% Find indicies and arrange them into a cell
temp0 = cell(1,dim(1));
for i=1:dim(1)
    for j=1:dim(2)
        if A(i,j) ~= 0
            temp0{i}(j) = j;
        end
        temp0{i} = temp0{i}(temp0{i}~=0);
    end
end
%the ith index of temp shows the row number, jth index shows column number.
index1 = [];

for i = 1:length(temp0)
    tempindex1 = ones(length(temp0{i}),1)*i;
    tempindex2=[];
    for j = 1:length(temp0{i})
        tempindex2 = [tempindex2;temp0{i}(j)];
    end
    tempind = cat(2,tempindex1,tempindex2);
    index1 = [index1;tempind];
end

Aind = cell(1,length(inC));

for i=1:length(inC)
    temp = find(index1(:,1)==i);
    for j = temp
        Aind{i} = [Aind{i},index1(j,:)];
    end
end

%% Multiplication
tic

for i = 1:dim(1)
    Aindsize = size(Aind{i});
    Aindsize = Aindsize(1);
    for k = 1:dim(1)
    temp = zeros(1,Aindsize);
        for j = 1:Aindsize
            temp(j) = A(Aind{i}(j,1),Aind{i}(j,2))*B(Aind{i}(j,2),k);
        end
        temp = sum(temp);
        inC(i,k) = temp;
    end
end

toc