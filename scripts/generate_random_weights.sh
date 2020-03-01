#!/bin/bash

RUNS=5
DATASETS=( "../datasets/cit-patents/cit-Patents-default" "../datasets/soc-livejournal/soc-LiveJournal1-default" "../datasets/twitter_rv/twitter_rv-default" )

randomize () {
    python ../preprocessor/isomorph.py weighted $1 > $2
}

for dataset in "${DATASETS[@]}"
do
    echo $dataset
    DATASET_FILE="${dataset}.txt"
    WEIGHT_FILE_BASE="${dataset}-weighted"
    for run in $(seq 1 $RUNS)
    do
        WEIGHT_FILE="${WEIGHT_FILE_BASE}-${run}.txt"
        randomize $DATASET_FILE $WEIGHT_FILE
    done 
done
