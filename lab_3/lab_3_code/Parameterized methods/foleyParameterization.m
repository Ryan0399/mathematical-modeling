function t=foleyParameterization(x,y)
% Foley-Nielsen参数化
% input-平面点列坐标x,y
% output-参数结点t
n=length(x);t=zeros(1,n);
P=[x(:) y(:)];
d=zeros(1,n-1);
for i=1:n-1
    d(i)=norm(P(i+1,:)-P(i,:));
end
t(2)=t(1)+d(1)*(1+3*angle(P(1,:),P(2,:),P(3,:))*d(2)/(2*(d(1)+d(2))));
for i=2:n-2
    t(i+1)=t(i)+d(i)*(1+3*angle(P(i-1,:),P(i,:),P(i+1,:))*d(i-1)/(2*(d(i-1)+d(i)))+...
        3*angle(P(i,:),P(i+1,:),P(i+2,:))*d(i+1)/(2*(d(i+1)+d(i))));
end
t(n)=t(n-1)+d(n-1)*(1+3*angle(P(n-2,:),P(n-1,:),P(n,:))*d(n-2)/(2*(d(n-2)+d(n-1))));
t=t/t(end);
end

function alpha=angle(p_1,p,p_2)
alpha=pi-acos(dot(p_1-p,p_2-p)/(norm(p_1-p)*norm(p_2-p)));
alpha=min([alpha pi/2]);
end