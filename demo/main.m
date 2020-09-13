clc
clear
%原始数据
%输入端数据
%导入数据
load spectra_data.mat
 
% 随机产生训练集和测试集
temp = randperm(size(NIR,1));
% 训练集——50个样本
P_train = NIR(temp(1:50),:)';
T_train = octane(temp(1:50),:)';
% 测试集——10个样本
P_test = NIR(temp(51:end),:)';
T_test = octane(temp(51:end),:)';
N = size(P_test,2);
 
%数据归一化
[p_train, ps_input] = mapminmax(P_train,0,1);
p_test = mapminmax('apply',P_test,ps_input);
[t_train, ps_output] = mapminmax(T_train,0,1);
 
%创建网络
net = newff(p_train,t_train,9);
 
% 设置训练参数
net.trainParam.epochs = 1000;
net.trainParam.goal = 1e-3;
net.trainParam.lr = 0.01;
 
%训练网络
net = train(net,p_train,t_train);
 
%仿真测试
t_sim = sim(net,p_test);
 
%数据反归一化
T_sim = mapminmax('reverse',t_sim,ps_output);
 
%相对误差error
error = abs(T_sim - T_test)./T_test;
 
%决定系数R^2
R2 = (N * sum(T_sim .* T_test) - sum(T_sim) * sum(T_test))^2 / ((N * sum((T_sim).^2) - (sum(T_sim))^2) * (N * sum((T_test).^2) - (sum(T_test))^2)); 
 
%结果对比
result = [T_test' T_sim' error']
%绘图
figure
plot(1:N,T_test,'b:*',1:N,T_sim,'r-o')
legend('真实值','预测值')
xlabel('预测样本')
ylabel
string = {['R^2=' num2str(R2)]};
title(string)


q=-read
a=q(1,:)
b=q(2,:)
c=q(3,:)
d=q(8,:)
e=q(9,:)
f=q(10,:)
g=q(11,:)
h=q(4,:)
i=q(5,:)
j=q(6,:)
k=q(7,:)%目标端数据
p=[a;b;c;d;e;f; g;i;j;k]
n=q(12,:)%输出端数据矩阵
t=[n]
%利用mapminmax函数对数据归一化
[pn,input_str]=mapminmax(p)
[tn,output_str]=mapminmax(t)
%建立神经网络
net = newff(pn,tn,21)
%输入数据，输出数据，隐含层的个数（此处为21），此处为单隐含层
%设置训练参数
net.trainParam.epochs = 1000;       %迭代次数
net.trainParam.goal = 1e-14;         %训练目标
net.trainParam.lr = 0.01;           %学习率
net.divideFcn''
%训练网络
net = train(net,pn,tn);
%自带的图形，第一个是通过迭代的训练过程，第二个是梯度，交叉验证过程，第三个是回归的结果
%仿真测试
t_sim = sim(net,pn);
%t_sim是仿真中得到的数据值
T_sim = mapminmax('reverse',t_sim,output_str)