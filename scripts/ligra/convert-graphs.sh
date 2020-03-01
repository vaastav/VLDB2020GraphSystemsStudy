#!/bin/bash

DATASET=$1
xpath=${DATASET%/*} 
xbase=${DATASET##*/}
xfext=${xbase##*.}
xpref=${xbase%.*}
BASENAME=${xpath}/${xpref}

SUFFIXES=( "-default" "-degree" "-revdegree" )
NZ_SUFFIXES=( "-default_nz" "-degree_nz" "-revdegree_nz" )
CONV=../../ligra/utils/SNAPtoAdj

convert_to_ligra () {
    $CONV $1 $2
}

for suffix in "${SUFFIXES[@]}"
do
    INPUT="${BASENAME}${suffix}.txt"
    OUTPUT="${BASENAME}${suffix}-ligra.txt"
    echo $INPUT $OUTPUT
    convert_to_ligra $INPUT $OUTPUT
done

for suffix in "${NZ_SUFFIXES[@]}"
do
    INPUT="${BASENAME}${suffix}.txt"
    OUTPUT="${BASENAME}${suffix}-ligra.txt"
    echo $INPUT $OUTPUT
    convert_to_ligra $INPUT $OUTPUT
done
