#!/bin/bash

DATASETS=( "stats/kron/kron" "stats/parmat/parmat" "stats/cit_patents/cit_patents" "stats/twitter_rv/twitter_rv" "stats/soc_livejournal/soc-livejournal" )

for dataset in "${DATASETS[@]}"
do
    echo "$dataset"
    ./collect_cache_results.sh pr $dataset "${dataset}_pr"
    ./collect_cache_results.sh cc $dataset "${dataset}_cc"
done
