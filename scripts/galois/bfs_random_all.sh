#!/bin/bash

echo "Cit Patents"
./bfs_random.sh ../../datasets/cit-patents/cit-Patents-default.gr stats/cit_patents/cit_patents ../../preprocessor/bfsnodes_cit_patents.txt
echo "Soc Livejournal"
./bfs_random.sh ../../datasets/soc-livejournal/soc-LiveJournal1-default.gr stats/soc_livejournal/soc_livejournal ../../preprocessor/bfsnodes_soc_livejournal.txt
echo "Twitter"
./bfs_random.sh ../../datasets/twitter_rv/twitter_rv-default.gr stats/twitter_rv/twitter_rv ../../preprocessor/bfsnodes_twitter_rv.txt
