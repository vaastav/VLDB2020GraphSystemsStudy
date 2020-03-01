#!/bin/bash

DATASET=$1
xpath=${DATASET%/*} 
xbase=${DATASET##*/}
xfext=${xbase##*.}
xpref=${xbase%.*}
BASENAME=${xpath}/${xpref}

#SUFFIXES=( "-default" "-degree" "-revdegree" )
#NZ_SUFFIXES=( "-default_nz" "-degree_nz" "-revdegree_nz" )
SUFFIXES=( "-default" )
CONV=../../preprocessor/gemini_convert

convert_to_gemini () {
    $CONV -f $1 -o $2 -y
}

for suffix in "${SUFFIXES[@]}"
do
    INPUT="${BASENAME}${suffix}.txt"
    OUTPUT="${BASENAME}${suffix}-gemini.bin"
    convert_to_gemini $INPUT $OUTPUT
done

for suffix in "${NZ_SUFFIXES[@]}"
do
    INPUT="${BASENAME}${suffix}.txt"
    OUTPUT="${BASENAME}${suffix}-gemini.bin"
    convert_to_gemini $INPUT $OUTPUT
done
