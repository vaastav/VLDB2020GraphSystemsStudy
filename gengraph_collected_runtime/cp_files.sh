#!/bin/bash
set -x


for ((scale=16; scale <=26; scale ++ )); do
	dirname="s${scale}_stats"
	mkdir -p $dirname
	cp /mnt/Graphs/gen_graphs/smooth_kron_gen/s${scale}_e16/graph_s${scale}_e16_pr_runtime /mnt/Graphs/gen_graphs/smooth_kron_gen/s${scale}_e16/graph_s${scale}_e16_pr_runtime_packed /mnt/Graphs/gen_graphs/smooth_kron_gen/s${scale}_e16/graph_s${scale}_e16_pr_runtime_packed-sync.out /mnt/Graphs/gen_graphs/smooth_kron_gen/s${scale}_e16/graph_s${scale}_e16_pr_runtime-sync.out $dirname/
	cp /mnt/Graphs/gen_graphs/smooth_kron_gen/s${scale}_e16/graph_s${scale}_e16_tc_runtime /mnt/Graphs/gen_graphs/smooth_kron_gen/s${scale}_e16/graph_s${scale}_e16_tc_runtime_packed /mnt/Graphs/gen_graphs/smooth_kron_gen/s${scale}_e16/graph_s${scale}_e16_tc_runtime_packed-sync.out /mnt/Graphs/gen_graphs/smooth_kron_gen/s${scale}_e16/graph_s${scale}_e16_tc_runtime-sync.out $dirname/
	cp /mnt/Graphs/gen_graphs/smooth_kron_gen/s${scale}_e16/graph_s${scale}_e16_info $dirname/



done
