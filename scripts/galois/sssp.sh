#!/bin/bash

source ./galois.sh

DATASET_BASE=$1
OUTFILE_BASE=$2
ITERATIONS=$3
START_NODE=$4
SSSP=$BUILD_DIR/lonestar/sssp/sssp
#SUFFIXES=( "-default" "-degree" "-bfs" "-revdegree" "-pack" "-spack" )
SUFFIXES=( "-default" )
#pdegree not being generated because of segfault

sssp () {
    (/usr/bin/time -f "%e,%U,%S" $SSSP -algo=deltaTile -startNode=$START_NODE $1) 2>>$2
    echo "$(cat $2),deltaTile,$1,$3" > $2
    (/usr/bin/time -f "%e,%U,%S" $SSSP -algo=deltaStep -startNode=$START_NODE $1) 2>>$2
    echo "$(cat $2),deltaStep,$1,$3" > $2
    (/usr/bin/time -f "%e,%U,%S" $SSSP -algo=serDeltaTile -startNode=$START_NODE $1) 2>>$2
    echo "$(cat $2),serDeltaTile,$1,$3" > $2
    (/usr/bin/time -f "%e,%U,%S" $SSSP -algo=serDelta -startNode=$START_NODE $1) 2>>$2
    echo "$(cat $2),serDelta,$1,$3" > $2
    (/usr/bin/time -f "%e,%U,%S" $SSSP -algo=dijkstraTile -startNode=$START_NODE $1) 2>>$2
    echo "$(cat $2),dijkstraTile,$1,$3" > $2
    (/usr/bin/time -f "%e,%U,%S" $SSSP -algo=dijkstra -startNode=$START_NODE $1) 2>>$2
    echo "$(cat $2),dijkstra,$1,$3" > $2
    (/usr/bin/time -f "%e,%U,%S" $SSSP -algo=topo -startNode=$START_NODE $1) 2>>$2
    echo "$(cat $2),topo,$1,$3" > $2
    (/usr/bin/time -f "%e,%U,%S" $SSSP -algo=topoTile -startNode=$START_NODE $1) 2>>$2
    echo "$(cat $2),topoTile,$1,$3" > $2
}

for suffix in "${SUFFIXES[@]}"
do
    OUTFILE="${OUTFILE_BASE}${suffix}-weighted-sssp-max-deg.csv"
    echo "StartNode $START_NODE"
    echo "Real,User,Sys,Algorithm,File,Iteration" > $OUTFILE
    rm $OUTFILE
    for run in $(seq 1 5)
    do
        echo "Run Number ${run}"
        DATASET="${DATASET_BASE}${suffix}-weighted-${run}.gr"
        for iteration in $(seq 1 $ITERATIONS)
        do
            sssp $DATASET $OUTFILE $iteration
        done
    done
done

