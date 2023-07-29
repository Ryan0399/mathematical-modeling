function t=chordLengthParameterization(x,y)
% 弦长参数化
% input-平面点列坐标x,y
%output-参数结点t
n=length(x);
t=zeros(1,n);
d=zeros(1,n-1);P=[x(:) y(:)];
for i=1:n-1
    d(i)=norm(P(i+1,:)-P(i,:));
end
for i=2:n
    t(i)=t(i-1)+d(i-1);
end
t=t/t(end);
end