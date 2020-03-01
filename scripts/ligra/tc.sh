#!/bin/bash
set -x # line nos for triage 
#adding this as a test line to confirm git isn't screwed up
source ./ligra.sh
DATASET_BASE=$1
OUTFILE_BASE=$2
ITERATIONS=$3
TC=$APPS_DIR/Triangle
SUFFIXES=( "-default" "-degree" "-bfs" "-revdegree" )
NZ_SUFFIXES=( "-default_nz" "-degree_nz" "-revdegree_nz" )
tc () {
    
    #echo "PR,$1" >> $2 
    /usr/bin/time -f "%e,%U,%S" --output="$2" --append $TC $1  
    
}

tc_cache () {

    #echo "PR" >> $2
    sudo perf stat -o $2 --append -e cache-references,cache-misses $TC $1 
    
}

for suffix in "${SUFFIXES[@]}"
do
    DATASET="${DATASET_BASE}${suffix}-ligra.txt"
    OUTFILE="${OUTFILE_BASE}${suffix}-tc-ligra.csv"
    OUTFILE_CACHE="${OUTFILE_BASE}${suffix}-cache-tc-ligra.csv"
    #check and delete old log files
    if [  -f $OUTFILE ]; then
	rm $OUTFILE
    fi
    if [  -f $OUTFILE_CACHE ]; then
	rm $OUTFILE_CACHE
    fi	
    #echo "Real,User,Sys,Algorithm,Iteration" > $OUTFILE
    for iteration in $(seq 1 $ITERATIONS)
    do
        tc $DATASET $OUTFILE
        #tc_cache $DATASET $OUTFILE_CACHE
	
	done
done


for suffix in "${NZ_SUFFIXES[@]}"
do
    DATASET="${DATASET_BASE}${suffix}-ligra.txt"
    OUTFILE="${OUTFILE_BASE}${suffix}-tc-ligra.csv"
    OUTFILE_CACHE="${OUTFILE_BASE}${suffix}-cache-tc-ligra.csv"

    #Check and delete the previous log files	
    if [  -f $OUTFILE ]; then
        rm $OUTFILE
    fi

    if [  -f $OUTFILE_CACHE ]; then
        rm $OUTFILE_CACHE
    fi

    #echo "Real,User,Sys,Algorithm,Iteration" > $OUTFILE
    for iteration in $(seq 1 $ITERATIONS)
    do
        tc $DATASET $OUTFILE
        #tc_cache $DATASET $OUTFILE_CACHE
	done
done

