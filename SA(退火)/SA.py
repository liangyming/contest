import numpy as np

city_size = 20      #城市总数
t0 = 100            #初始温度
lowest_t = 0.001    #最低温度
iteration = 500     #设置迭代次数

city_data = np.loadtxt("city.csv", dtype=np.int, delimiter=",")

#求出所有的距离
def distance(city_data):
    dis = np.zeros([city_size, city_size])
    for i in range(city_size):
        for j in range(city_size):
            dis[i, j] = np.sqrt(np.square(city_data[i,0]-city_data[j,0]) + np.square(city_data[i,1]-city_data[j,1]))
    return dis

#计算所有路径对应的距离
def cal_newpath(dis_mat, path):
    sum_dis = 0
    for j in range(city_size - 1):
        sum_dis = dis_mat[path[j], path[j+1]] + sum_dis
    return sum_dis

#点对点距离矩阵
dis_mat = distance(city_data)
#初始路径
path = np.random.permutation(city_size)
#初始距离
dis = cal_newpath(dis_mat, path)
#初始温度
t_current = t0

while (t_current > lowest_t):           #外循环，改变温度
    count_iter = 0                      #迭代次数计数
    while (count_iter < iteration):     #内循环，连续多次不接受新的状态或者是迭代多次,跳出内循环
        i = 0
        j = 0
        while(i == j):                  #防止随机了同一城市
            i = np.random.randint(0, city_size)
            j = np.random.randint(0, city_size)
        path_new = path.copy()
        path_new[i], path_new[j] = path_new[j], path_new[i]     #任意交换两个城市的位置,产生新解
        #计算新解的距离
        dis_new = cal_newpath(dis_mat, path_new)
        #求差
        dis_delta = dis_new - dis
        #选择
        if dis_delta < 0:
            path = path_new
            dis = dis_new
            print('温度', t_current, '距离：', dis, '路径', path)
        elif np.exp(-dis_delta/t_current) > np.random.random():
            path = path_new
            dis = dis_new
            print('温度', t_current, dis_delta, '距离：', dis, '路径', path)

        count_iter += 1
    t_current = 0.99 * t_current        #降温

print("-----------------------------------------------------------------------------\n")
print('最短距离：', dis)
print('最短路径：', path)