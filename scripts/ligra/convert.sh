#!/bin/bash
#set -x #print line nos for triage 
#adding this as a test line to confirm git isn't screwed up
source ./ligra.sh
DATASET_BASE=$1
OUTFILE_BASE=$1
CONV=$UTILS_DIR/SNAPtoAdj
SUFFIXES=( "-default" "-degree" "-bfs" "-revdegree" )
NZ_SUFFIXES=( "-default_nz" "-degree_nz" "-revdegree_nz" )

for suffix in "${SUFFIXES[@]}"
do
    INPUT="${DATASET_BASE}${suffix}.txt"
    OUTPUT="${OUTFILE_BASE}${suffix}-ligra.txt"

    $CONV $INPUT $OUTPUT

done


for suffix in "${NZ_SUFFIXES[@]}"
do
    INPUT="${DATASET_BASE}${suffix}.txt"
    OUTPUT="${OUTFILE_BASE}${suffix}-ligra.txt"

    $CONV $INPUT $OUTPUT
done

