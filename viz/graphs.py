import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
import matplotlib
import pylab as pl
from math import pi

class Radar(object):

    def __init__(self, fig, titles, labels, rect=None):
        if rect is None:
            rect = [0.05, 0.05, 0.95, 0.95]
    
        self.n = len(titles)
        self.angles = [a if a <=360. else a - 360. for a in np.arange(90, 90+360, 360.0/self.n)]
        self.axes = [fig.add_axes(rect, projection="polar", label="axes%d" % i) 
                         for i in range(self.n)]
    
        self.ax = self.axes[0]
        self.ax.set_thetagrids(self.angles, labels=titles, fontsize=12, weight="bold", color="black")
    
        for ax in self.axes[1:]:
            ax.patch.set_visible(False)
            ax.grid("off")
            ax.xaxis.set_visible(False)
            self.ax.yaxis.grid(False)
    
        for ax, angle, label in zip(self.axes, self.angles, labels):
            ax.set_rgrids(range(1, len(titles)+1), labels=label, angle=angle, fontsize=12)
            ax.spines["polar"].set_visible(False)
            ax.set_ylim(0, len(label)+1)  
            ax.xaxis.grid(True,color='black',linestyle='-')
            pos=ax.get_rlabel_position()
            ax.set_rlabel_position(pos+7)
    
    def plot(self, values, *args, **kw):
        angle = np.deg2rad(np.r_[self.angles, self.angles[0]])
        values = np.r_[values, values[0]]
        self.ax.plot(angle, values, *args, **kw)

def plot_radar_graph(N, categories, labels, values, groups, name):
    angles = [n / float(N) * 2 * pi for n in range(N)]
    angles += angles[:1]

    colors = ['b', 'g', 'r', 'c', 'm', 'y']
     
    # Initialise the spider plot
    ax = plt.subplot(111, polar=True)
 
    # If you want the first axis to be on top:
    ax.set_theta_offset(pi / 2)
    ax.set_theta_direction(-1)
    plt.xticks(angles[:-1],categories)

    for label,i in zip(ax.get_xticklabels(),range(0,len(angles))):
        angle_rad=angles[i]
        if angle_rad <= pi/2:
            ha= 'left'
            va= "bottom"
            angle_text=angle_rad*(-180/pi)+90
        elif pi/2 < angle_rad <= pi:
            ha= 'left'
            va= "top"
            angle_text=angle_rad*(-180/pi)+90
        elif pi < angle_rad <= (3*pi/2):
            ha= 'right'
            va= "top"  
            angle_text=angle_rad*(-180/pi)-90
        else:
            ha= 'right'
            va= "bottom"
            angle_text=angle_rad*(-180/pi)-90
        label.set_rotation(angle_text)
        label.set_verticalalignment(va)
        label.set_horizontalalignment(ha)

    max_range = 0
    for l in labels:
        if len(l) > max_range:
            max_range = len(l)

    for i in range(N):
        ax.set_rlabel_position(angles[i] * 57.2598)
        ticks = []
        for j in range(max_range):
            ticks += [(j+1) * 10]
        ax.set_rgrids(ticks[:len(labels[i])], angle = angles[i] * 57.2598, labels=labels[i], fontsize=12)
#       plt.yticks(ticks[:len(labels[i])], labels[i])
    plt.ylim(0, (max_range+1) * 10)
    print("Here")
    print(angles)
    for i in range(len(values)):
        val = list((np.asarray(values[i]) + 1) * 10)
        val += val[:1]
        ax.plot(angles, val, linewidth=1, linestyle='solid', label=groups[i])
        ax.fill(angles, val, colors[i], alpha=0.1)
    plt.legend(loc='lower left', bbox_to_anchor=(0.0,1.01), frameon=False)
    print("Now")
    plt.savefig(name + ".png", bbox_inches="tight")
    print("Done")

def plot_radar_graph2(values, categories, labels, groups, name):
    fig = pl.figure(figsize=(8,4))
    radar = Radar(fig, categories, labels)
    colors = ['b', 'g', 'r', 'c', 'm', 'y']
    for i in range(len(values)):
        radar.plot(values[i], "-", color=colors[i],alpha=0.5, label=groups[i])
    fig = plt.gcf()
    fig.set_size_inches(6, 10, forward=True)
    fig.savefig(name + '.png', dpi=100, bbox_inches="tight", pad_inches=1)


def plot_vertical_bars(name, data, xlabels, legend, ylabel,figsize=(8,4), xlabel="", title="", yticks=None):
    N = len(data[0])
    indices = np.arange(N)
    patterns = ('//', '\\\\', 'o', '+', 'x', '*', '-', 'O', '.')
    # width = 1 / len(data)
    # This is the fitting width. Right now, lets just hardcode it
    if N == 1:
        new_indices = np.arange(len(legend))
        fig = plt.figure(figsize=figsize)
        ax = fig.add_subplot(111)
        i = 0
        rects = ()
        for d in data:
            rect = ax.bar([new_indices[i]],d, width=0.5, hatch=patterns[i]) 
            rects = rects + (rect[0],)
            i += 1

        if title != "":
            ax.set_title(title)
        if yticks is not None:
            ax.set_yticks(yticks)
        ax.set_ylabel(ylabel)
        ax.set_xticks([])
        ax.set_xticklabels([])
        ax.set_xlabel(xlabels[0])
        ax.set_xlim(new_indices[0]-1, new_indices[len(legend)-1]+1)
        ax.legend(rects, legend, ncol=len(data))
        plt.savefig(name + ".png", bbox_inches="tight")
    if N >= 2:
        width = 0.15
        fig = plt.figure(figsize=figsize)
        ax = fig.add_subplot(111)

        i = 0
        rects = ()
        for d in data:
            rect = ax.bar(indices + width * i, d, width, hatch=patterns[i])
            rects = rects + (rect[0],)
            i += 1

        if title != "":
            ax.set_title(title)
        if yticks is not None:
            ax.set_yticks(yticks)
        ax.set_ylabel(ylabel)
        ax.set_xticks(indices + width * (len(data)-1)/2)
        ax.set_xticklabels(xlabels)
        if xlabel != "":
            ax.set_xlabel(xlabel)
        ax.legend(rects, legend, frameon=False, ncol=len(data))
        plt.savefig(name + ".png", bbox_inches="tight")

def plot_vertical_bars_errors(name, data, xlabels, legend, ylabel,figsize, xlabel, err_data,title=""):
    matplotlib.rcParams.update({'errorbar.capsize': 2})
    N = len(data[0])
    indices = np.arange(N)
    patterns = ('//', '\\\\', 'o', '+', 'x', '*', '-', 'O', '.')
    # width = 1 / len(data)
    # This is the fitting width. Right now, lets just hardcode it
    if N == 1:
        new_indices = np.arange(len(legend))
        fig = plt.figure(figsize=figsize)
        ax = fig.add_subplot(111)
        i = 0
        rects = ()
        for d,e in zip(data, err_data):
            rect = ax.bar([new_indices[i]],d, width=0.5, hatch=patterns[i], yerr=e) 
            rects = rects + (rect[0],)
            i += 1

        if title != "":
            ax.set_title(title)
        ax.set_ylabel(ylabel)
        ax.set_xticks([])
        ax.set_xticklabels([])
        ax.set_xlabel(xlabels[0])
        ax.set_xlim(new_indices[0]-1, new_indices[len(legend)-1]+1)
        ax.legend(rects, legend, ncol=len(data))
        plt.savefig(name + ".png", bbox_inches="tight")
    if N >= 2:
        width = 0.15
        fig = plt.figure(figsize=figsize)
        ax = fig.add_subplot(111)

        i = 0
        rects = ()
        for d,e in zip(data,err_data):
            rect = ax.bar(indices + width * i, d, width, hatch=patterns[i], yerr=e)
            rects = rects + (rect[0],)
            i += 1

        if title != "":
            ax.set_title(title)
        ax.set_ylabel(ylabel)
        ax.set_xticks(indices + width * (len(data)-1)/2)
        ax.set_xticklabels(xlabels)
        if xlabel != "":
            ax.set_xlabel(xlabel)
        ax.legend(rects, legend, frameon=False, ncol=len(data))
        plt.savefig(name + ".png", bbox_inches="tight")

def plot_heatmap(name, data, xlabels, ylabels, inverty=True):
    cmap = sns.cm.rocket_r
    ax = sns.heatmap(data, linewidth=0.5, xticklabels=xlabels, yticklabels=ylabels, cmap=cmap)
    if inverty:
        ax.invert_yaxis()
    plt.savefig(name + ".png", bbox_inches="tight")

def plot_multiloglog(name,lox,loy,xlabel,ylabel, legend):
    fig = plt.figure()
    patterns = ( 'o', 's', '+', 'x', '*')
    colors = ('r', 'b', 'g', 'y', 'black')
    ax = fig.add_subplot(111)
    rects = ()
    for i in range(len(lox)):
        x = lox[i]
        y = loy[i]
        marker = patterns[i]
        rect = ax.plot(x,y,marker=marker, linewidth=0, color=colors[i])
        rects += (rect[0],)

    ax.set_xscale('log')
    ax.set_yscale('log')
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.legend(rects, legend, loc='lower left', bbox_to_anchor=(0.0,1.01), frameon=False)
    plt.savefig(name + ".png", bbox_inches="tight")

def plot_loglog(name,x,y,xlabel,ylabel):
    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.plot(x,y,marker='o', linewidth=0)
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.set_xscale('log')
    ax.set_yscale('log')
    plt.savefig(name + ".png", bbox_inches="tight")

def plot_multiloglogline(name,lox,loy,xlabel,ylabel,legend):
    fig = plt.figure()
    ax = fig.add_subplot(111)
    rects = ()
    colors = ('r', 'b', 'g', 'y', 'black')
    for i  in range(len(lox)):
        x = lox[i]
        y = loy[i]
        rect = ax.plot(x,y,marker='.', color=colors[i])
        rects += (rect[0],)
    ax.set_xscale('log')
    ax.set_yscale('log')
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.legend(rects, legend, loc='lower left', bbox_to_anchor=(0.0, 1.01), frameon=False)
    plt.savefig(name + ".png", bbox_inches="tight")

def plot_log_line(name,x,y,xlabel,ylabel):
    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.plot(x,y,marker='.')
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.set_xscale('log')
    ax.set_yscale('log')
    plt.savefig(name + ".png", bbox_inches="tight")

def plot_bargraph(name, data, xlabel, ylabel):
    y_pos = np.arange(len(data))
    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.bar(y_pos, data)
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.axhline(data.mean(), color='red', linewidth=2)
    plt.savefig(name + ".png", bbox_inches="tight")

def plot_bargraph_labels(name, data, labels, xlabel, ylabel):
    y_pos = np.arange(len(data))
    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.bar(y_pos, data)
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.set_xticks(y_pos)
    ax.set_xticklabels(labels)
    plt.savefig(name + ".png", bbox_inches="tight")

def plot_histogram_bins(name, data, bins, xlabel, ylabel):
    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.hist(data, bins)
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    plt.savefig(name + ".png", bbox_inches="tight")

def cost_plot():
    twitter_orderings = []
    twitter_orderings += [[5.9, 30], [24.2, 93]]
    uk_orderings = []
    uk_orderings += [[13.5, 57], [11.7, 58.8]]
    labels = ('Union Find', 'Label Prop')
    legend = ('Hilbert Order', 'Vertex Order')
    plot_vertical_bars("cost_twitter_rv", twitter_orderings, labels, legend)
    plot_vertical_bars("cost_uk-2007-05", uk_orderings, labels, legend)

