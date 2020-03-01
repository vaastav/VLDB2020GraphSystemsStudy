#!/bin/bash

source ./graphchi.sh

DATASET_BASE=$1
OUTFILE_BASE=$2
ITERATIONS=$3
BFS=$BUILD_DIR/example_apps/bfs
SUFFIXES=( "-default" "-degree" "-bfs" "-revdegree" "-random" )
NZ_SUFFIXES=( "-default_nz" "-degree_nz" "-revdegree_nz" "-random_nz" )
#pdegree not being generated because of segfault

bfs () {
    (/usr/bin/time -f "%e,%U,%S" $BFS -algo=AsyncTile -exec=$3 $1) 2>>$2
    echo "$(cat $2),AsyncTile,$4" > $2
    (/usr/bin/time -f "%e,%U,%S" $BFS -algo=SyncTile -exec=$3 $1) 2>>$2
    echo "$(cat $2),SyncTile,$4" > $2 
    (/usr/bin/time -f "%e,%U,%S" $BFS -algo=Sync2p -exec=$3 $1) 2>>$2
    echo "$(cat $2),Sync2p,$4" > $2 
    (/usr/bin/time -f "%e,%U,%S" $BFS -algo=Sync2pTile -exec=$3 $1) 2>>$2
    echo "$(cat $2),Sync2pTile,$4" > $2 
}

for suffix in "${SUFFIXES[@]}"
do
    DATASET="${DATASET_BASE}${suffix}.gr"
    OUTFILE="${OUTFILE_BASE}${suffix}-bfs-parallel.csv"
    OUTFILE2="${OUTFILE_BASE}${suffix}-bfs-serial.csv"
    rm $OUTFILE
    rm $OUTFILE2
    echo "Real,User,Sys,Algorithm,Iteration" > $OUTFILE
    for iteration in $(seq 1 $ITERATIONS)
    do
        bfs $DATASET $OUTFILE PARALLEL $iteration
    done
done

for suffix in "${NZ_SUFFIXES[@]}"
do
    DATASET="${DATASET_BASE}${suffix}.gr"
    OUTFILE="${OUTFILE_BASE}${suffix}-bfs-parallel.csv"
    OUTFILE2="${OUTFILE_BASE}${suffix}-bfs-serial.csv"
    rm $OUTFILE
    rm $OUTFILE2
    echo "Real,User,Sys,Algorithm,Iteration" > $OUTFILE
    for iteration in $(seq 1 $ITERATIONS)
    do
        bfs $DATASET $OUTFILE2 SERIAL $iteration
    done
done

