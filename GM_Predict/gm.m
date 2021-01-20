clc;
clear;
x0 = [71.1, 72.4, 72.4, 72.1, 71.4, 72.0, 71.6];
x1 = cumsum(x0);
Y = x0;
Y(1) = [];
Y = Y';
%���鳤��
n = length(x0)
B = [-0.5 * (x1(1:n-1) + x1(2:n)); ones(1, n-1)];
%������a��b
ab = inv(B*B')*B*Y;
% Ԥ���������
R = [];
R(1) = x0(1);
%�����n+10Ϊ����ҪԤ��ĸ���,������һ��������ʾ
for i = 2:(n + 10)
    R(i) = (x0(1) - ab(2)/ab(1)) / exp(ab(1)*(i-1)) + ab(2)/ab(1);
end
%�õ�Ԥ�����������
res = [];
res(1) = x0(1);
for i = 2:(n + 10)
    res(i) = R(i) - R(i-1);
end
plot(1:n+10, res, 'o', 1:n, x0);
