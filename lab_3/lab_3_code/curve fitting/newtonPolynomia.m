function f = newtonPolynomia(s,t,x)
%构造牛顿插值多项式
n=length(x);
f=zeros(1,n);
N=length(s)-1;
for i = 2:N+1
    for j = N+1:-1:i
        s(j)=(s(j)-s(j-1))/(t(j)-t(j-i+1));
    end
end
for j=1:n
    f(j)=s(N+1);
    for i=N+1:-1:2
        f(j)=s(i-1)+(x(j)-t(i-1))*f(j);
    end
end