#!/bin/bash
#set -x #print line nos for triage 
#adding this as a test line to confirm git isn't screwed up
source ./graphchi.sh
DATASET_BASE=$1
OUTFILE_BASE=$2
ITERATIONS=$3
CC=$BUILD_DIR/example_apps/connectedcomponents
SUFFIXES=( "-default" "-degree" "-bfs" "-revdegree" )
NZ_SUFFIXES=( "-default_nz" "-degree_nz" "-revdegree_nz" )
cc () {
    
    echo "CC,$1,$3" >> $2 
    /usr/bin/time -f "%e,%U,%S" --output="$2" --append $CC filetype edgelist file $1 > "$1-out" 2>"$1-err" 

}

cc_cache () {

    echo "CC ">> $2
    sudo perf stat -o $2 --append -e cache-references,cache-misses $CC filetype edgelist file $1 > "$1-cache.out" 2>"$1-cache.err"
}

for suffix in "${SUFFIXES[@]}"
do
    DATASET="${DATASET_BASE}${suffix}.txt"
    OUTFILE="${OUTFILE_BASE}${suffix}-cc.csv"
    OUTFILE_CACHE="${OUTFILE_BASE}${suffix}-cache-cc.csv"
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
        cc $DATASET $OUTFILE $iteration
        #cc_cache $DATASET $OUTFILE_CACHE
	
	#delete all shards created by Graphchi
	find $(dirname $DATASET) -name "*.txt[._]*" -type f -exec rm -f "{}" \; -o -name "*.txt[._]*" -type d -exec rm -rf "{}" \;
    done
done


for suffix in "${NZ_SUFFIXES[@]}"
do
    DATASET="${DATASET_BASE}${suffix}.txt"
    OUTFILE="${OUTFILE_BASE}${suffix}-cc.csv"
    OUTFILE_CACHE="${OUTFILE_BASE}${suffix}-cache-cc.csv"
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
        cc $DATASET $OUTFILE $iteration
        #cc_cache $DATASET $OUTFILE_CACHE

	#delete all shards created by Graphchi
        find $(dirname $DATASET) -name "*.txt[._]*" -type f -exec rm -f "{}" \; -o -name "*.txt[._]*" -type d -exec rm -rf "{}" \; 
    done
done

