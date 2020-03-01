#!/bin/bash

source ./gemini.sh
DATASET=$1
OUTFILE_BASE=$2
NODES_FILE=$3
VERTICES=$4
OUTFILE="${OUTFILE_BASE}-default-bfs.txt"
rm $OUTFILE
BFS=$TOOLKIT_DIR/bfs

bfs () {
    (/usr/bin/time -f "%e,%U,%S" $BFS $DATASET $VERTICES $1) &>> $OUTFILE 
}

IFS=$'\n' read -d '' -r -a vertices < $3
for vertex in ${vertices[@]}
do
    echo $vertex
    bfs $vertex
done
