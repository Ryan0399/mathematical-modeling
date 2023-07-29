function p=gaussType(x,y,t)
% Gauss基函数型参数曲线拟合
% input-平面点列坐标x,y
%           参数结点t
g=@(u,s,t) exp(-(t-u).^2/(2*s^2));
n=length(x);
u=linspace(0,1,1001);
G=ones(n+1);s=0.1;
for i=2:n+1
    G(1:n,i)=g(t(i-1),s,t(:));
end
P=[x(:) y(:)];
P(end+1,:)=[1 1];
c=G\P;
U=ones(length(u),n+1);
for i=1:length(u)
    U(i,2:n+1)=g(t(:),s,u(i));
end
a=U*c;
% figure(2);subplot(1,4,2);
p=plot(a(:,1),a(:,2),'g');hold on;

end