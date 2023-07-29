function [z,h]=cubicNaturalSpline(y,t)
n=length(t);
z=zeros(1,n);
h=zeros(1,n-1);b=zeros(1,n-1);
for i=1:n-1
    h(i)=t(i+1)-t(i);
    b(i)=6*(y(i+1)-y(i))/h(i);
end
u=zeros(1,n-2);v=zeros(1,n-2);
u(1)=2*(h(1)+h(2));
v(1)=b(1)-b(2);
for i=2:n-2
    u(i)=2*(h(i+1)+h(i))-h(i)^2/(u(i-1));
    v(i)=b(i+1)-b(i)-h(i)*v(i-1)/u(i-1);
end
z(n)=0;
for i=n-1:-1:2
    z(i)=(v(i-1)-h(i)*z(i+1))/u(i-1);
end
z(1)=0;
end