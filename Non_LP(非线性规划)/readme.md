### matlab求解非线性规划函数
```javascript
[x, y] = fmincon(fun, x0, A, B, aeq, beq, lb, ub, nonlcon, options);
```
和线性规划差不多，多出来的就是`fun`是线性约束函数，`nonlcon`是非线性约束函数
==**此代码选取的例子如下**==
$$
min\quad f(x)=x_1^2+x_2^2+x_3^2+8
$$
$$
\begin{cases}
x_1^2-x_2+x_3^2\ge 0 \\
x_1+x_2^2+x_3^3\le 20 \\
-x_1-x_2^2+2=0 \\
x_2+2x_3^2=3 \\
x_1,x_2,x_3\ge 0
\end{cases}
$$