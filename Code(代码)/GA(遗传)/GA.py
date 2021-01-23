import numpy as np

city_size = 19          #城市数量
cross_rate = 0.1        #交叉率
mutate_rate = 0.02      #变异率
nums = 500              #种群个体数
generate = 3000         #代数

class GA(object):
    def __init__(self, city_size, cross_rate, mutate_rate, nums):
        self.city_size = city_size
        self.cross_rate = cross_rate
        self.mutate_rate = mutate_rate
        self.nums = nums
        #初始生成的种群
        self.pop = np.vstack([np.random.permutation(city_size) for _ in range(nums)])

    #计算种群适应度和每个个体的总距离
    def get_fitness(self, pop, dis):
        sum_distance = np.zeros(nums)
        for i in range(nums):
            for j in range(city_size - 1):
                sum_distance[i] += dis[pop[i, j], pop[i, j+1]]
        fitness = np.exp(self.city_size*2 / sum_distance)
        return fitness, sum_distance

    #自然选择
    def select(self, fitness):
        idx = np.random.choice(np.arange(self.nums), size=self.nums, replace=True, p=fitness/fitness.sum())
        return self.pop[idx]

    #基因交配
    def crossover(self, parent, pop):
        if np.random.rand() < self.cross_rate:
            #在种群中选择另一个个体
            index = np.random.randint(0, self.nums, size=1)
            cross_points = np.random.randint(0, 2, self.city_size).astype(np.bool)
            #要保留的基因点,也就是城市为false
            keep_city = parent[~cross_points]
            #np.ravel()多维数组转一维,把要交叉的随机个体中要替换的部分选出来
            swap_city = pop[index, np.isin(pop[index].ravel(), keep_city, invert=True)]
            parent[:] = np.concatenate((keep_city, swap_city))
        return parent

    #个体变异
    def mutate(self, child):
        for point in range(self.city_size):
            if np.random.rand() < self.mutate_rate:
                swap_point = np.random.randint(0, self.city_size)
                swapA, swapB = child[point], child[swap_point]
                child[point], child[swap_point] = swapB, swapA
        return child

    #进化的整个步骤
    def evolve(self, fitness):
        pop = self.select(fitness)
        pop_copy = pop.copy()
        for parent in pop:
            child = self.crossover(parent, pop_copy)
            child = self.mutate(child)
            parent[:] = child
        self.pop = pop

#求出所有的距离
def distance(city_data):
    dis = np.zeros([city_size, city_size])
    for i in range(city_size):
        for j in range(city_size):
            dis[i, j] = np.sqrt(np.square(city_data[i,0]-city_data[j,0]) + np.square(city_data[i,1]-city_data[j,1]))
    return dis

def main():
    #读取城市坐标
    city_data = np.loadtxt("city.csv", dtype=np.int, delimiter=",")
    dis = distance(city_data)
    ga = GA(city_size, cross_rate, mutate_rate, nums)
    for g in range(generate):
        fitness, sum_distance = ga.get_fitness(ga.pop, dis)
        ga.evolve(fitness)
        best_idx = np.argmax(fitness)
        print('代数:', g, '| best fit: %.2f' % fitness[best_idx], ' ', ga.pop[best_idx], sum_distance[best_idx])


if __name__ == '__main__':
    main()