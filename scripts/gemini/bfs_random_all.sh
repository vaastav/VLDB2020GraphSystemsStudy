#!/bin/bash

echo "Cit Patents"
./bfs_random.sh ../../datasets/cit-patents/cit-Patents-default-gemini.bin stats/cit_patents/cit_patents ../../preprocessor/bfsnodes_cit_patents.txt 6009555
echo "Soc Livejournal"
./bfs_random.sh ../../datasets/soc-livejournal/soc-LiveJournal1-default-gemini.bin stats/soc_livejournal/soc_livejournal ../../preprocessor/bfsnodes_soc_livejournal.txt 4847571
echo "Twitter"
./bfs_random.sh ../../datasets/twitter_rv/twitter_rv-default-gemini.bin stats/twitter_rv/twitter_rv ../../preprocessor/bfsnodes_twitter_rv.txt 61578415
