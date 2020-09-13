clc
clear all
%原始数据
%输入端数据
q=read('C:\Users\Administrator\desktop')
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