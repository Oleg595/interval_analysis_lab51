import math

import matplotlib.pyplot as plt
import matplotlib.patches as pth
from numpy.linalg import lstsq
import numpy as np

N = 10

x = [i for i in range(1, N + 1)]
y = [200 * i + int(5 * i * np.random.normal(size=1)) for i in range(1, N + 1)]
for elem in y:
    print(elem)

plt.scatter(x, y)
plt.xlabel("Номер измерения")
plt.ylabel("Показания энкодера")
plt.show()

A = [[x[i], 1] for i in range(N)]
b = [y[i] for i in range(N)]

b1, b0 = lstsq(A, b, rcond=None)[0]
print(b1, b0)

y_calc = [b1 * x[i] + b0 for i in range(N)]
plt.plot(x, y_calc)
plt.legend(["Результат МНР метода"])
plt.scatter(x, y)
plt.xlabel("Номер измерения")
plt.ylabel("Показания энкодера")
plt.show()

eps = [math.fabs(y_calc[i] - y[i]) for i in range(N)]
intervals = [[y[i] - eps[i], y[i] + eps[i]] for i in range(N)]


def plotIntervals(intervals, x, y_calc):
    fig, ax = plt.subplots()
    ax.plot(x, y_calc, linewidth=0.5)
    ax.legend(["Значение МНР"])
    for i in range(len(intervals)):
        ax.add_patch(
            pth.Rectangle((x[i], intervals[i][0]), 0, (intervals[i][1] - intervals[i][0]),
                          linewidth=1, edgecolor='r', facecolor='none'))

    plt.xlabel("Номер измерения")
    plt.ylabel("Приближённое показание энкодера")
    plt.show()


plotIntervals(intervals, x, y_calc)
max_rad = max(eps) + 30

for i in range(N):
    mid = intervals[i][0] + eps[i]
    intervals[i] = [mid - max_rad, mid + max_rad]
    print([(intervals[i][0] + intervals[i][1]) / 2, (intervals[i][1] - intervals[i][0]) / 2])

plotIntervals(intervals, x, y_calc)
