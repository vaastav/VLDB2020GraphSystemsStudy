#!/bin/bash
#set -e
ITERATIONS=25

echo "Cit-patents"
./tc.sh $(pwd)/../../datasets/cit-patents/cit-Patents $(pwd)/stats/cit_patents/cit_patents $ITERATIONS 
echo "Kron"
./tc.sh $(pwd)/../../datasets/kron/kron $(pwd)/stats/kron/kron $ITERATIONS 
echo "Parmat"
./tc.sh $(pwd)/../../datasets/parmat/parmat $(pwd)/stats/parmat/parmat $ITERATIONS 
echo "Soc-Livejournal"
./tc.sh $(pwd)/../../datasets/soc-livejournal/soc-LiveJournal1 $(pwd)/stats/soc_livejournal/soc-livejournal $ITERATIONS 
echo "Twitter"
./tc.sh $(pwd)/../../datasets/twitter_rv/twitter_rv $(pwd)/stats/twitter_rv/twitter_rv $ITERATIONS 

