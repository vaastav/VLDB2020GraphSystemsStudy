#!/bin/bash

source ./gemini.sh

DATASET=$1
OUTFILE=$2
PR_ITERATIONS=$3
RUNS=$4
VERTICES=$5
OUTFILE_CACHE=$6
PR=$TOOLKIT_DIR/pagerank

pagerank () {
    rm $OUTFILE
    echo "Real,User,Sys,Algorithm,Iteration" > $OUTFILE
    for run in $(seq 1 $RUNS)
    do
        (/usr/bin/time -f "%e,%U,%S" $PR $DATASET $VERTICES $PR_ITERATIONS) 2>>$OUTFILE
        echo "$(cat $OUTFILE),Sync,$run" > $OUTFILE
    done
}

pagerank_cache () {
    rm $OUTFILE_CACHE
    for run in $(seq 1 $RUNS)
    do
        echo "Sync" >> $OUTFILE_CACHE
        (sudo perf stat -e cache-references,cache-misses $PR $DATASET $VERTICES $PR_ITERATIONS) 2>>$OUTFILE_CACHE
    done
}

pagerank
#pagerank_cache
