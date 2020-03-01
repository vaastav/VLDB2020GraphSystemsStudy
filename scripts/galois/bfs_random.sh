#!/bin/bash

source ./galois.sh
DATASET=$1
OUTFILE_BASE=$2
NODES_FILE=$3
OUTFILE_P="${OUTFILE_BASE}-default-bfs-parallel.csv"
OUTFILE_S="${OUTFILE_BASE}-default-bfs-serial.csv"
rm $OUTFILE_P
rm $OUTFILE_S
echo "Real,User,Sys,Algorithm,Vertex_ID" > $OUTFILE_P
echo "Real,User,Sys,Algorithm,Vertex_ID" > $OUTFILE_S
BFS=$BUILD_DIR/lonestar/bfs/bfs

bfs () {
    (/usr/bin/time -f "%e,%U,%S" $BFS -algo=AsyncTile -exec=$3 -startNode=$4 $1) 2>>$2
    echo "$(cat $2),AsyncTile,$4" > $2
    (/usr/bin/time -f "%e,%U,%S" $BFS -algo=Async -exec=$3 -startNode=$4 $1) 2>>$2
    echo "$(cat $2),Async,$4" > $2
    (/usr/bin/time -f "%e,%U,%S" $BFS -algo=Sync -exec=$3 -startNode=$4 $1) 2>>$2
    echo "$(cat $2),Sync,$4" > $2
    (/usr/bin/time -f "%e,%U,%S" $BFS -algo=SyncTile -exec=$3 -startNode=$4 $1) 2>>$2
    echo "$(cat $2),SyncTile,$4" > $2 
    (/usr/bin/time -f "%e,%U,%S" $BFS -algo=Sync2p -exec=$3 -startNode=$4 $1) 2>>$2
    echo "$(cat $2),Sync2p,$4" > $2 
    (/usr/bin/time -f "%e,%U,%S" $BFS -algo=Sync2pTile -exec=$3 -startNode=$4 $1) 2>>$2
    echo "$(cat $2),Sync2pTile,$4" > $2 
}

IFS=$'\n' read -d '' -r -a vertices < $3
for vertex in ${vertices[@]}
do
    echo $vertex
    bfs $DATASET $OUTFILE_P PARALLEL $vertex
    bfs $DATASET $OUTFILE_S SERIAL $vertex
done
