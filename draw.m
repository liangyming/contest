%¹þ¹þ¹þ
data = csvread('1result.csv', 1, 0);
hold on
plot(data(:, 1), data(:, 2));
%243.86
aa = [0:0.01:290]
bb = [243.86 243.86]
plot(aa, bb, 'r--');
grid on;