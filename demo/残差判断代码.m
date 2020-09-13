X1=[51.93 52.51 54.70 43.14 43.85 44.48 44.61 52.08];%*除以去掉的56.96（最大值）得到Y1*
Y1=[0.91169241573 0.921875 0.96032303371 0.75737359551 0.76983848315 0.7808988764 0.78318117978 0.9143258427];%确定度或者隶属度
[n,m]=size(X1);%指标或事件重复次数
Ex=mean(X1)
En1=zeros(1,m);
for i=1:m
  En1(1,i)=abs(X1(1,i)-Ex)/sqrt(-2*log(0.9));
end
En=mean(En1);
He=0;
for i=1:m
  He=He+(En1(1,i)-En)^2;
end
En=mean(En1)
He=sqrt(He/(m-1))
hold on
for i=1:1000
  Enn=randn(1)*He+En;
  x(i)=randn(1)*Enn+Ex;
  y(i)=exp(-(x(i)-Ex)^2/(2*Enn^2));
  plot(x(i),y(i),'*')
end