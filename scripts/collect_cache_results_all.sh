#!/bin/bash

DATASETS=( "galois/stats/kron/kron" "galois/stats/parmat/parmat" "galois/stats/cit_patents/cit_patents" "galois/stats/twitter_rv/twitter_rv")

for dataset in "${DATASETS[@]}"
do
    #./collect_cache_results.sh pr $dataset "${dataset}_pr"
    ./collect_cache_results.sh cc $dataset "${dataset}_cc"
done
