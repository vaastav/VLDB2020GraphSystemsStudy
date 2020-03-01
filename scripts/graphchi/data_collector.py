import sys
import csv

class Stats:
    def __init__(self):
        self.refs = []
        self.misses = []
        self.times = []

def main():
    if len(sys.argv) < 3:
        print("Usage: python collector.py outfile file1 [file2 .... fileN]")
        sys.exit(1)
    outfile = sys.argv[1]
    files = sys.argv[2:]
    ordering_names = []
    ordering_stats = []
    for f in files:
        print(f)
        ordering = f.split('-')[1]
        ordering_names += [ordering]
        with open(f,'r') as inf:
            idx = 0
            values = {}
            current_algo = ""
            for line in inf:
                striped_line = line.strip()
                if striped_line.startswith("Performance"):
                    continue
                if striped_line != "":
                    if idx % 5 == 0:
                        current_algo = striped_line
                        if striped_line not in values:
                            values[striped_line] = Stats()
                    elif idx % 5 == 2:
                        num_refs = float(striped_line.split(' ')[0].replace(',',''))
                        val = values[current_algo]
                        val.refs += [num_refs]
                        values[current_algo]=val
                    elif idx % 5 == 3:
                        num_misses = float(striped_line.split(' ')[0].replace(',',''))
                        val = values[current_algo]
                        val.misses += [num_misses]
                        values[current_algo]=val
                    elif idx % 5 == 4:
                        total_time = float(striped_line.split(' ')[0].replace(',',''))
                        val = values[current_algo]
                        val.times += [total_time]
                        values[current_algo]=val
                    idx += 1
            ordering_stats += [values]
    with open(outfile,'w') as outf:
        writer = csv.writer(outf, delimiter=',')
        writer.writerow(['Ordering', 'Algo', 'Refs', 'Misses', 'Time'])
        for values,name in zip(ordering_stats,ordering_names):
            for algo, stats in values.items():
                for i in range(len(stats.times)):
                    writer.writerow([name, algo, stats.refs[i], stats.misses[i], stats.times[i]])

if __name__ == '__main__':
    main()
