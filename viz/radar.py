import numpy as np
from math import pi
import matplotlib.pyplot as plt

class Radar(object):
    def __init__(self, figure, title, labels, rect=None):
        if rect is None:
            rect = [0.05, 0.05, 0.9, 0.9]

        self.n = len(title)
        self.angles = np.arange(0, 360, 360.0/self.n)

        self.axes = [figure.add_axes(rect, projection='polar', label='axes%d' % i) for i in range(self.n)]

        self.ax = self.axes[0]
        self.ax.set_thetagrids(self.angles, labels=title, fontsize=12)

        max_label_len = len(labels[0]) + 1
        print(self.angles)

        for ax in self.axes[1:]:
            ax.patch.set_visible(False)
            ax.grid(False)
            ax.xaxis.set_visible(False)

        for ax, angle, label in zip(self.axes, self.angles, labels):
            ax.set_rgrids(range(1, 6), angle=angle, labels=label)
            ax.spines['polar'].set_visible(False)
            ax.set_ylim(0, max_label_len)

    def plot(self, values, *args, **kw):
        angle = np.deg2rad(np.r_[self.angles, self.angles[0]])
        values = np.r_[values, values[0]]
        self.ax.plot(angle, values, *args, **kw)


if __name__ == '__main__':
    fig = plt.figure(figsize=(8, 4))

    title = ["Storage", "Architecture", "Computation", "Memory", "Coord"]

    lab = [
        ["Mem", "Disk", " "],
        ["Central", "Dist", " "],
        ["BSP", "PSW", "TDM"],
        ["MP", "SM", "DF"],
        ["Sync", "Hybrid", "Async"]
    ]

    radar = Radar(fig, title, lab)
    radar.plot([2,2,1,1,1],  '-', lw=2, color='b', alpha=0.4, label='Pregel')
    radar.plot([1,2,3,2,2], '-', lw=2, color='r', alpha=0.4, label='Naiad')
    radar.plot([2,2,2,2,3], '-', lw=2, color='g', alpha=0.4, label='GraphChi')
    radar.ax.legend()

    fig.savefig('Systems.png')
