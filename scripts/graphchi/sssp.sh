#!/bin/bash

source ./galois.sh

DATASET_BASE=$1
OUTFILE_BASE=$2
SSSP=$BUILD_DIR/lonestar/sssp/sssp
SUFFIXES=( "-default" "-degree" "-bfs" "-revdegree" "-pack" "-spack" )
#pdegree not being generated because of segfault

sssp () {
    (/usr/bin/time -f "%e,%U,%S" $SSSP -algo=deltaTile $1) 2>>$2
    echo "$(cat $2),deltaTile" > $2
    (/usr/bin/time -f "%e,%U,%S" $SSSP -algo=deltaStep $1) 2>>$2
    echo "$(cat $2),deltaStep" > $2
    (/usr/bin/time -f "%e,%U,%S" $SSSP -algo=serDeltaTile $1) 2>>$2
    echo "$(cat $2),serDeltaTile" > $2
    (/usr/bin/time -f "%e,%U,%S" $SSSP -algo=serDelta $1) 2>>$2
    echo "$(cat $2),serDelta" > $2
    (/usr/bin/time -f "%e,%U,%S" $SSSP -algo=dijkstraTile $1) 2>>$2
    echo "$(cat $2),dijkstraTile" > $2
    (/usr/bin/time -f "%e,%U,%S" $SSSP -algo=dijkstra $1) 2>>$2
    echo "$(cat $2),dijkstra" > $2
    (/usr/bin/time -f "%e,%U,%S" $SSSP -algo=topo $1) 2>>$2
    echo "$(cat $2),topo" > $2
    (/usr/bin/time -f "%e,%U,%S" $SSSP -algo=topoTile $1) 2>>$2
    echo "$(cat $2),topoTile" > $2
}

for suffix in "${SUFFIXES[@]}"
do
    DATASET="${DATASET_BASE}${suffix}.gr"
    OUTFILE="${OUTFILE_BASE}${suffix}-sssp.csv"
    rm $OUTFILE
    echo "Real,User,Sys,Algorithm" > $OUTFILE
    sssp $DATASET $OUTFILE
done

