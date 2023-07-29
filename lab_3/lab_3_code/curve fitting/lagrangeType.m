function p=lagrangeType(x,y,t)
% Lagrange型参数曲线拟合
% input-平面点列坐标x,y
%           参数结点t
% n=length(x);
u=linspace(0,1,1001);
a=newtonPolynomia(x,t,u);
b=newtonPolynomia(y,t,u);
% P=[x(:) y(:)];
% A = fliplr(vander(t));
% c=A\P;
% B=fliplr(vander(u));
% B=B(1:end,1:n);
% a=B*c;
% figure(2);subplot(1,4,3);
p=plot(a,b,'m');hold on;
end