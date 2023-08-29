function C = binio(A,B)
%This code performs an approximate multiplication of two matrices of size
%nxn, where the first matrix A has a zero block on the index (2,1). The
%process is done in 5 steps.
n = size(A);
n = n(1);
m=n;
z = size(B);
z = z(1);
l=z;
%n = n(1);
nmin = 2;
C = zeros(size(A),'like',A);
lambda = 10^(-5); %Make sure to check this value; this is the approx. error.
if n<= nmin

    for i=1:m
        for j=1:l
            for p=1:l
                    C(i,j)=C(i,j)+ A(i,p)*B(p,j);          
            end
        end
    end
else
     m = n/2; u=1:m; v=m+1:n;

     M1 = binio(A(u,u)+A(v,v),lambda*B(u,u)+B(v,v));
     M2 = binio(A(v,v),-B(v,u)-B(v,v));
     M3 = binio(A(u,u),B(v,v));
     M4 = binio(lambda*A(u,v)+A(v,v),-lambda*B(u,u)+B(v,u));
     M5 = binio(A(u,u)+lambda*A(u,v), lambda*B(u,v)+B(v,v));

     C11 = 1/lambda*(M1+M2-M3+M4);
     C12 = 1/lambda*(-M3+M5);
     C21 = M4;
     C22 = M1-M5;

     C = [C11 C12; C21 C22];
end
