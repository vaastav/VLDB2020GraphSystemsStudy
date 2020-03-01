import csv
import sys
import os
import pandas as pd
import numpy as np
from graphs import plot_vertical_bars, plot_heatmap, plot_bargraph, plot_bargraph_labels, plot_loglog, plot_histogram_bins, plot_vertical_bars_errors, plot_radar_graph2

def get_algo_names(csv_file):
    df = pd.read_csv(csv_file)
    return df['Algorithm']

def get_real_time(csv_file):
    df = pd.read_csv(csv_file)
    return df['User']

def get_real_time_algos(algorithms, csv_file):
    df = pd.read_csv(csv_file)
    times = []
    errs = []
    for alg in algorithms:
        alg_filter = df['Algorithm'] == alg
        filtered_df = df[alg_filter]
        time = np.mean(filtered_df['User'].values[1:])
        err = np.std(filtered_df['User'].values[1:])
        times += [time]
        errs += [err]
    return times, errs

def vertical_stack_bars(benchmark, files):
    orderings = ()
    dataset = ""
    for f in files:
        bname = os.path.basename(f)
        dataset = bname.split('-')[0]
        ordering = bname.split('-')[1].split('.')[0]
        orderings = orderings + (ordering,)
    names_col = get_algo_names(files[0])
    algorithms = ()
    for n in names_col:
        algorithms = algorithms + (n,)
    time_cols = []
    for f in files:
        time_col = get_real_time(f)
        time_cols += [time_col]
    # Initialize the data array
    data = []
    for i in range(len(orderings)):
        col = []
        for t in time_cols[i]:
            col += [t]
        data += [col]
    plot_vertical_bars(benchmark + "_" + dataset, data, algorithms, orderings)

def vertical_stack_bars_errors(benchmark, files):
    orderings = ()
    dataset = ""
    for f in files:
        bname = os.path.basename(f)
        dataset = bname.split('-')[0]
        ordering = bname.split('-')[1].split('.')[0]
        orderings = orderings + (ordering,)
    names_col = get_algo_names(files[0])
    names_col = np.unique(names_col)
    algorithms = ()
    for n in names_col:
        algorithms = algorithms + (n,)
    time_cols = []
    err_cols = []
    for f in files:
        time_col, err_col = get_real_time_algos(names_col, f)
        time_cols += [time_col]
        err_cols += [err_col]
    data = []
    err_data = []
    for i in range(len(orderings)):
        col = []
        err_col = []
        for t in time_cols[i]:
            col += [t]
        for e in err_cols[i]:
            err_col += [e]
        data += [col]
        err_data += [err_col]
    plot_vertical_bars_errors(benchmark + "_" + dataset, data, algorithms, orderings, "Runtime (in s)", (8,4), "Algorithms", err_data)

def heatmap(name, csv_file, inverty=True, takeAvg=False):
    df = pd.read_csv(csv_file)
    col_names = list(df.columns.values)
    # Remove the Unnamed column name
    col_names = col_names[1:]
    row_names = df.iloc[:,0].tolist()
    data = df.values[:,1:].astype(float)
    if takeAvg:
        data = data / data.sum(axis=0)
    plot_heatmap(name,data,col_names, row_names, inverty)

def bargraph(name, csv_file):
    df = pd.read_csv(csv_file)
    vals = df['Total']
    plot_bargraph(name, vals.sort_values(ascending=False), name + " in sorted order", "Count")

def bargraph_labels(name, csv_file, col1, col2):
    df = pd.read_csv(csv_file)
    vals = df[col1]
    labels = df[col2]
    plot_bargraph_labels(name, vals, labels, name, col1)

def loglog(name, csv_file):
    df = pd.read_csv(csv_file)
    x = df['Degree']
    y = df['Count']
    plot_loglog(name, x, y, "Degree", "Count")

def hist(name, csv_file):
    df = pd.read_csv(csv_file)
    data = df['Zero_Vertices']
    print(len(data))
    unit = int(0.01 * len(data))
    bins = np.arange(0, len(data), unit)
    plot_histogram_bins(name, data, bins, 'Node Id range', 'Count')

def radar():
    categories = ["Storage", "Architecture", "Computation", "Memory Model", "Coord"]
    labels = [["Memory", "Disk", " "], ["Centralized", "Distributed", " "], ["BSP", "PSW", "TDM"], ["MP", "SM", "DF"], ["Sync", "Hybrid", "Async"]]
    groups = ["Pregel", "Naiad", "GraphChi"]
    values = []
    # Pregel Values
    values += [[2, 2, 1, 1, 1]]
    # Naiad Values
    values += [[1, 2, 3, 2, 2]]
    # GraphChi Values
    values += [[2, 2, 2, 2, 3]]
    plot_radar_graph2(values, categories, labels, groups, "graph_systems") 

def main():
    option = sys.argv[1]
    if option == 'vstack':
        # sys.argv[2] : The name of the benchmark
        # sys.argv[3] : The name of all the files that should be used to generate the data
        vertical_stack_bars(sys.argv[2], sys.argv[3:])
    elif option == 'vstackerr':
        vertical_stack_bars_errors(sys.argv[2], sys.argv[3:])
    elif option == 'hmap':
        heatmap(sys.argv[2], sys.argv[3])
    elif option == 'grad-hmap':
        heatmap(sys.argv[2], sys.argv[3], False, True)
    elif option == 'grad-hmapf':
        heatmap(sys.argv[2], sys.argv[3], True, False)
    elif option == 'bar':
        bargraph(sys.argv[2], sys.argv[3])
    elif option == 'barl':
        bargraph_labels(sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])
    elif option == 'loglog':
        loglog(sys.argv[2], sys.argv[3])
    elif option == 'hist':
        hist(sys.argv[2], sys.argv[3])
    elif option == 'radar':
        radar()

if __name__ == '__main__':
    main()
