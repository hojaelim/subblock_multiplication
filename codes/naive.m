function [C] = naive( A,B )
[m,n]=size(A);
[k,l]=size(B);
if(n~=k)
    C=[];
    disp('Error, not able to multiply matrices');
    return
end
C=zeros(size(A),'like',A);
for i=1:m;
    for j=1:l;
        for p=1:n; 
                C(i,j)=C(i,j)+ A(i,p)*B(p,j);          
        end
    end
end