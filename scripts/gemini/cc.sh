#!/bin/bash

source ./gemini.sh

DATASET=$1
OUTFILE=$2
RUNS=$3
VERTICES=$4
OUTFILE_CACHE=$5
CC=$TOOLKIT_DIR/cc

connected () {
    rm $OUTFILE
    echo "Real,User,Sys,Algorithm,Iteration" > $OUTFILE
    for run in $(seq 1 $RUNS)
    do
        (/usr/bin/time -f "%e,%U,%S" $CC $DATASET $VERTICES) 2>>$OUTFILE
        echo "$(cat $OUTFILE),Connected,$run" > $OUTFILE
    done
}

connected_cache () {
    rm $OUTFILE_CACHE
    for run in $(seq 1 $RUNS)
    do
        echo "Connected" >> $OUTFILE_CACHE
        (sudo perf stat -e cache-references,cache-misses $CC $DATASET $VERTICES) 2>>$OUTFILE_CACHE
    done
}

connected
#connected_cache
