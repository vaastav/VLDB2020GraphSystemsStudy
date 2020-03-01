#!/bin/bash

ITERATIONS=25

./triangle-counting.sh ../../datasets/smooth_kron_graphs/kron_8_16_5 stats/rmat/smooth_kron $ITERATIONS
./triangle-counting.sh ../../datasets/parmat_16_16/parmat_16_16 stats/rmat/parmat $ITERATIONS
./triangle-counting.sh ../../datasets/ligrarmat/ligrarmat_16_16_default stats/rmat/ligrarmat $ITERATIONS
./triangle-counting.sh ../../datasets/snap_kron/graph stats/rmat/snap_kron $ITERATIONS
./triangle-counting.sh ../../datasets/graph500/graph500_kron stats/rmat/graph500 $ITERATIONS
./triangle-counting.sh ../../datasets/snap_rmat/snap_16_16_converted $ITERATIONS
