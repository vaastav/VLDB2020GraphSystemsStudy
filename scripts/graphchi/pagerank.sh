#!/bin/bash
#set -x #print line nos for triage 
#adding this as a test line to confirm git isn't screwed up
source ./graphchi.sh
DATASET_BASE=$1
OUTFILE_BASE=$2
ITERATIONS=$3
PRANK=$BUILD_DIR/example_apps/pagerank_functional
SUFFIXES=( "-default" "-degree" "-bfs" "-revdegree" )
#SUFFIXES=( "-degree" )
NZ_SUFFIXES=( "-default_nz" "-degree_nz" "-revdegree_nz" )
pagerank () {
    
    echo "PR-Sync,$1,$3" >> $2 
    /usr/bin/time -f "%e,%U,%S" --output="$2" --append $PRANK mode sync filetype edgelist file $1 niters 10 > "$1-sync.out" 2>"$1-sync.err" 
    
    echo "PR-Async,$1,$3" >> $2
    /usr/bin/time -f "%e,%U,%S" --output="$2" --append $PRANK mode semisync filetype edgelist file $1 niters 10 > "$1-async.out" 2>"$1-async.err"
    
    
}

pagerank_cache () {

    cd $GRAPHCHI_ROOT ##This is a filthy hack to get this working. It should have picked this variable defined in graphchi.sh
    echo "PR-Async\n" >> $2
    sudo perf stat -o $2 --append -e cache-references,cache-misses $PRANK mode semisync filetype edgelist file $1 niters 10 > "$1-async.cache.out" 2>"$1-async.cache.err"
    echo "PR-Sync\n" >> $2
    sudo perf stat -o $2 --append -e cache-references,cache-misses $PRANK mode sync filetype edgelist file $1 niters 10 > "$1-sync.cache.out" 2>"$1-sync.cache.err"
}

for suffix in "${SUFFIXES[@]}"
do
    DATASET="${DATASET_BASE}${suffix}.txt"
    OUTFILE="${OUTFILE_BASE}${suffix}-pr.csv"
    OUTFILE_CACHE="${OUTFILE_BASE}${suffix}-cache-pr.csv"
    #check and delete old log files
    #if [  -f $OUTFILE ]; then
	#rm $OUTFILE
    #fi
    if [  -f $OUTFILE_CACHE ]; then
	    rm $OUTFILE_CACHE
    fi	
    #echo "Real,User,Sys,Algorithm,Iteration" > $OUTFILE
    for iteration in $(seq 1 $ITERATIONS)
    do
        #pagerank $DATASET $OUTFILE $iteration
        pagerank_cache $DATASET $OUTFILE_CACHE
	
	#delete all shards created by Graphchi
	find $(dirname $DATASET) -name "*.txt[._]*" -type f -exec rm -f "{}" \; -o -name "*.txt[._]*" -type d -exec rm -rf "{}" \;
    done
done


for suffix in "${NZ_SUFFIXES[@]}"
do
    DATASET="${DATASET_BASE}${suffix}.txt"
    OUTFILE="${OUTFILE_BASE}${suffix}-pr.csv"
    OUTFILE_CACHE="${OUTFILE_BASE}${suffix}-cache-pr.csv"
    #Check and delete the previous log files	
    #if [  -f $OUTFILE ]; then
    #    rm $OUTFILE
    #fi

    if [  -f $OUTFILE_CACHE ]; then
        rm $OUTFILE_CACHE
    fi

    #echo "Real,User,Sys,Algorithm,Iteration" > $OUTFILE
    for iteration in $(seq 1 $ITERATIONS)
    do
        #pagerank $DATASET $OUTFILE $iteration
        pagerank_cache $DATASET $OUTFILE_CACHE

	#delete all shards created by Graphchi
        find $(dirname $DATASET) -name "*.txt[._]*" -type f -exec rm -f "{}" \; -o -name "*.txt[._]*" -type d -exec rm -rf "{}" \; 
    done
done

