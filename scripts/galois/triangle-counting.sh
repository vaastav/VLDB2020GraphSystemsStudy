#!/bin/bash

source ./galois.sh

DATASET_BASE=$1
OUTFILE_BASE=$2
ITERATIONS=$3
TC=$BUILD_DIR/lonestar/triangles/triangles
#SUFFIXES=( "-default" "-degree" "-bfs" "-revdegree" "-random" )
#NZ_SUFFIXES=( "-default_nz" "-degree_nz" "-revdegree_nz" "-random_nz" )
SUFFIXES=( "-default" )
#pdegree not being generated because of segfault

triangle_counting () {
    (/usr/bin/time -f "%e,%U,%S" $TC -algo=nodeiterator -t=16 -statFile=$3 $1) 2>>$2
    echo "$(cat $2),NodeIterator,$4" > $2
    (/usr/bin/time -f "%e,%U,%S" $TC -algo=edgeiterator -t=16 -statFile=$3 $1) 2>>$2
    echo "$(cat $2),EdgeIterator,$4" > $2
}

for suffix in "${SUFFIXES[@]}"
do
    DATASET="${DATASET_BASE}${suffix}.gr"
    OUTFILE="${OUTFILE_BASE}${suffix}-tc.csv"
    STATFILE="${OUTFILE_BASE}${suffix}-stat-tc.txt"
    TRIGFILE="${DATASET}.triangles"
    rm $OUTFILE
    echo "Real,User,Sys,Algorithm,Iteration" > $OUTFILE
    for iteration in $(seq 1 $ITERATIONS)
    do
        triangle_counting $DATASET $OUTFILE $STATFILE $iteration
    done
    rm $TRIGFILE
done

#for suffix in "${NZ_SUFFIXES[@]}"
#do
#    DATASET="${DATASET_BASE}${suffix}.gr"
#    OUTFILE="${OUTFILE_BASE}${suffix}-tc.csv"
#    STATFILE="${OUTFILE_BASE}${suffix}-stat-tc.txt"
#    TRIGFILE="${DATASET}.triangles"
#    rm $OUTFILE
#    echo "Real,User,Sys,Algorithm" > $OUTFILE
#    triangle_counting $DATASET $OUTFILE $STATFILE
#    rm $TRIGFILE
#done

