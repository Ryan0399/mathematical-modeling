function v=generatePolynomial(z,h,y,t,x)
N=length(t);
A=zeros(1,N-1);B=zeros(1,N-1);C=zeros(1,N-1);
for i=1:N-1
    A(i)=(z(i+1)-z(i))/(6*h(i));
    B(i)=z(i)/2;
    C(i)=-h(i)*z(i+1)/6-h(i)*z(i)/3+(y(i+1)-y(i))/h(i);
end

for i=1:N-1
    if x>=t(i)&&x<=t(i+1)
        v=y(i)+(x-t(i))*(C(i)+(x-t(i))*(B(i)+(x-t(i))*A(i)));
        break;
    end
end
end