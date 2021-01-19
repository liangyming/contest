clc;
clear;
x0 = [71.1, 72.4, 72.4, 72.1, 71.4, 72.0, 71.6];
x1 = cumsum(x0);
Y = x0';
%数组长度
n = length(x0)
B = [-0.5 * (x1(1:n-1) + x1(2:n)), ones(1, n-1)]
%求解参数a和b
ab = inv(B*B') * B' * Y;
% 预测后续数据
R = [];
R(1) = x0(1);
%下面的n+10为后面要预测的个数,可以用一个变量表示
for i = 2:(n + 10)
    R(i) = (x0(1) - ab(2)/ab(1)) / exp(a*(i-1)) + ab(2)/ab(1);
end
%得到预测出来的数据
res = [];
res(1) = x0(1);
for i = 2:(n + 10)
    res(i) = R(i) - R(i-1);
end
plot(1:n+10, res, 'o', 1:n, x0);

