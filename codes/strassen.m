function c = strassen(a,b)
n = size(a);
n = n(1);
m=n;
l=n;
nmin = 128;
c = zeros(size(b),'like',b);
if n<= nmin
%    c = a*b;
    for i=1:m
        for j=1:l
            for p=1:n
                    c(i,j)=c(i,j)+ a(i,p)*b(p,j);          
            end
        end
    end
else
    m = n/2; u=1:m; v=m+1:n;
    p1 = strassen(a(u,u)+a(v,v),b(u,u)+b(v,v));
    p2 = strassen(a(v,u)+a(v,v),b(u,u));
    p3 = strassen(a(u,u),b(u,v)-b(v,v));
    p4 = strassen(a(v,v),b(v,u)-b(u,u));
    p5 = strassen(a(u,u)+a(u,v),b(v,v));
    p6 = strassen(a(v,u)-a(u,u),b(u,u)+b(u,v));
    p7 = strassen(a(u,v)-a(v,v),b(v,u)+b(v,v));
    c = [p1+p4-p5+p7, p3+p5; p2+p4, p1-p2+p3+p6];
end


