function p=RBFType(x,y,t)
% RBF型参数曲线拟合
% input-平面点列坐标x,y
%           参数结点t
eg=0.01;% 误差平方
sc=1.2;% 目标分布常数
netx=newrb(t,x,eg,sc,100);
nety=newrb(t,y,eg,sc,100);
u=linspace(0,1,1001);
X=netx(u);Y=nety(u);
% figure(2);subplot(1,4,4);
p=plot(X,Y,'b');hold on;

end