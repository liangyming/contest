%第一题
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
fun5 = inline('0.0102*(173-y)', 'x', 'y');
%t时间区间,435.5*60 / 78 = 335 s;
[x1, y1] = ode23(fun1, [0, 335], 25);