function p=leastSquaresType(x,y,t)
% 最小二乘型参数曲线拟合
% input-平面点列坐标x,y
%           参数结点t
labmda=0.8;
n=length(x);m=ceil(labmda*n);
u=linspace(0,1,1001);
A = fliplr(vander(t));
A=A(1:n,1:m);
P=[x(:) y(:)];
% c=lsqr(A,x');d=lsqr(A,y');
B=fliplr(vander(u));
B=B(1:end,1:m);
% c=[c(:) d(:)];
% c=linsolve(A.'*A,A.'*P);
[Q,R] = qr(A,'econ'); % 
c= R\(Q'*P); % 
a=B*c;
% figure(2);subplot(1,4,1);
p=plot(a(:,1),a(:,2),'r');hold on;

end