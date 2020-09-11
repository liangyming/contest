%第一题
clc;
clear;
data = xlsread("fujian.xlsx");
w = 0.015
v = 70;
v = v / 60;
len = v * data(:, 1);
data(:, 3) = len;
%循环求解参数an
an = [];
for i = 1:708
    %不同区域加热温度t不同
    if (len(i) - 25) < (35.5*5 - 2.5)
        t = 175;
    elseif (len(i) - 25) < (35.5*6 - 2.5)
        t = 195;
    elseif (len(i) - 25) < (35.5*7 - 2.5)
         t = 235;
    elseif (len(i) - 25) < (35.5*9 - 2.5)
        t = 255;
    else
        t = 25;
    end
    a = w / (t - data(i, 2)) * (data(i+1,2) - data(i,2)) / 0.5;
    an = [an, a];
end
disp(mean(an));
%解微分方程
%T = [173, 198, 230, 257, 25];
%temp = a/w; temp = 0.0102
fun1 = inline('0.0102*(173-y)', 'x', 'y');
fun2 = inline('0.0102*(198-y)', 'x', 'y');
fun3 = inline('0.0102*(230-y)', 'x', 'y');
fun4 = inline('0.0102*(257-y)', 'x', 'y');
fun5 = inline('0.0102*(25-y)', 'x', 'y');
%t时间区间,435.5*60 / 78 = 335 s;
%t = [153.5, 181, 208, 263]
[x1, y1] = ode23(fun1, [0:0.5:153.5], 25);
[x2, y2] = ode23(fun2, [154:0.5:181], 141.9893);
[x3, y3] = ode23(fun3, [181.5:0.5:208], 170.6329);
[x4, y4] = ode23(fun4, [208.5:0.5:263], 205.3906);
[x5, y5] = ode23(fun5, [263.5:0.5:335], 241.1252);
%整合
time = [0:0.5:335];
res = [y1; y2; y3; y4; y5];
plot(time, res);