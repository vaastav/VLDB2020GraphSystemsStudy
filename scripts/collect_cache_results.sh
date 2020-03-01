#!/bin/bash

BENCHMARK=$1
INFILE_BASE=$2
OUTFILE="${3}_cache.csv"
NZ_OUTFILE="${3}_nz_cache.csv"

DATAFILES=()
NZ_DATAFILES=()
SUFFIXES=( "-default" "-degree" "-revdegree" ) #"-bfs" )
#NZ_SUFFIXES=( "-default_nz" "-degree_nz" "-revdegree_nz" ) #"-random_nz" )

for suffix in "${SUFFIXES[@]}"
do
    INFILE="${INFILE_BASE}${suffix}-cache-${BENCHMARK}.csv"
    DATAFILES+=(${INFILE})
done

for suffix in "${NZ_SUFFIXES[@]}"
do
    INFILE="${INFILE_BASE}${suffix}-cache-${BENCHMARK}.csv"
    NZ_DATAFILES+=(${INFILE})
done 

python data_collector.py $OUTFILE ${DATAFILES[@]}
python data_collector.py $NZ_OUTFILE ${NZ_DATAFILES[@]}
