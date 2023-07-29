function p=cubicSplineType(x,y,t)
% 三次自然样条函数型参数曲线拟合
% input-平面点列坐标x,y
%           参数结点t
u=linspace(0,1,1001);ax=zeros(1,1001);bx=zeros(1,1001);
[zx,hx]=cubicNaturalSpline(x,t);
[zy,hy]=cubicNaturalSpline(y,t);
for i=1:1001
    ax(i)=generatePolynomial(zx,hx,x,t,u(i));
    bx(i)=generatePolynomial(zy,hy,y,t,u(i));
end
p=plot(ax,bx,Color=[0.8500 0.3250 0.0980]);hold on;
end