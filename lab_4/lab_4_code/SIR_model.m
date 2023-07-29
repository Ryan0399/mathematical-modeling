clear
clc

% 模型参数
alpha = 0; % 自然出生率
beta = 0; % 自然死亡率
delta = 1; % 日感染率
epsilon = 0; % 日死亡率
theta = 0.3; % 日治愈率
N=7800*(10^6); % 初始健康人数

f1 = @(t, s, i, r) -delta * s * i;
f2 = @(t, s, i, r) delta * s * i - (epsilon + theta) * i;
f3 = @(t, s, i, r) (epsilon + theta) * i;


b = 100; a = 0; h = 1;
n = (b - a) / h + 1;
S = size(1, n); I = size(1, n); R = size(1, n);
S(1) = (N-1)/N;
I(1) = 1/N;
R(1) = 0;


k = zeros(3, 4); t = a;

for i = 2:n
    k(:, 1) = [f1(t, S(i - 1), I(i - 1), R(i - 1)); f2(t, S(i - 1), I(i - 1), R(i - 1)); f3(t, S(i - 1), I(i - 1), R(i - 1))];
    k(:, 2) = [f1(t + h / 2, S(i - 1) + h * k(1, 1) / 2, I(i - 1) + h * k(2, 1) / 2, R(i - 1) + h * k(3, 1) / 2); ...
                   f2(t + h / 2, S(i - 1) + h * k(1, 1) / 2, I(i - 1) + h * k(2, 1) / 2, R(i - 1) + h * k(3, 1) / 2); ...
                   f3(t + h / 2, S(i - 1) + h * k(1, 1) / 2, I(i - 1) + h * k(2, 1) / 2, R(i - 1) + h * k(3, 1) / 2)];
    k(:, 3) = [f1(t + h / 2, S(i - 1) + h * k(1, 2) / 2, I(i - 1) + h * k(2, 2) / 2, R(i - 1) + h * k(3, 2) / 2); ...
                   f2(t + h / 2, S(i - 1) + h * k(1, 2) / 2, I(i - 1) + h * k(2, 2) / 2, R(i - 1) + h * k(3, 2) / 2); ...
                   f3(t + h / 2, S(i - 1) + h * k(1, 2) / 2, I(i - 1) + h * k(2, 2) / 2, R(i - 1) + h * k(3, 2) / 2)];
    k(:, 4) = [f1(t + h, S(i - 1) + h * k(1, 3), I(i - 1) + h * k(2, 3), R(i - 1) + h * k(3, 3)); ...
                   f2(t + h, S(i - 1) + h * k(1, 3), I(i - 1) + h * k(2, 3), R(i - 1) + h * k(3, 3)); ...
                   f3(t + h, S(i - 1) + h * k(1, 3), I(i - 1) + h * k(2, 3), R(i - 1) + h * k(3, 3))];
    S(i) = S(i - 1) + h * sum([1 2 2 1] .* k(1, :)) / 6;
    I(i) = I(i - 1) + h * sum([1 2 2 1] .* k(2, :)) / 6;
    R(i) = R(i - 1) + h * sum([1 2 2 1] .* k(3, :)) / 6;
    t = t + h;
end

T=linspace(a,b,n);
plot(T,S,'LineWidth',2);hold on;
plot(T,R,'LineWidth',2);hold on;
plot(T,I,'LineWidth',2);
legend('S','R','I');