clc,clear;
f = [2; 3; -5];
a = [-2 5 -1; 1 3 1];
b = [10; 12];
aeq = [1 1 1];
beq = 7;
lb = zeros(3, 1);
%f取-f意为取反的最小值
[x, fval] = linprog(-f, a, b, aeq, beq, lb);
fprintf('x1=%.4f, x2=%.4f, x3=%.4f\nz=%.4f\n', x, -fval);