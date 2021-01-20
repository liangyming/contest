clc,clear;
fid = fopen('data.txt','r');
%% 可变参数,n1为第一个矩阵维度,即准则层指标数,n2为方案层个数
n1 = 6;n2 = 3;
%准则层数据在a中
a = [];
for i = 1:n1
    tmp = str2num(fgetl(fid));
    a = [a; tmp];
end

%% 这里的方案层数据分别在n1(6)个bi中
for i = 1:n1
    str1 = char(['b', int2str(i), '=[];']);
    str2 = char(['b', int2str(i), '=[b',int2str(i), ';tmp];']);
    eval(str1);
    for j = 1:n2
        tmp = str2num(fgetl(fid));
        eval(str2);
    end
end

ri = [0, 0, 0.58, 0.90, 1.12, 1.24, 1.32, 1.41, 1.45]; %一致性指标
[x, y] = eig(a);
%找到最大特征值
lamda = max(diag(y));
%最大特征值对应下标
num = find(diag(y) == lamda);
%归一化求得权重
w0 = x(:, num) / sum(x(:, num));
%一致性检验,如果cr<0.1就可以接受
cr0 = (lamda-n1) / (n1-1) / ri(n1)
for i = 1:n1
    [x, y] = eig(eval(char(['b', int2str(i)])));
    lamda = max(diag(y));
    num = find(diag(y) == lamda);
    w1(:, i) = x(:, num) / sum(x(:, num));
    cr1(i) = (lamda-n2)/(n2-1)/ri(n2);
end
cr1, ts = w1*w0, cr = cr1*w0
fprintf('总权值矩阵：%.4f, %.4f, %.4f\n一致性为：%.4f\n', ts', cr);