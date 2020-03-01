#!/bin/bash
#set -e
ITERATIONS=25

echo "Cit-patents"
./cc.sh $(pwd)/../../datasets/cit-patents/cit-Patents $(pwd)/stats/cit_patents/cit_patents $ITERATIONS 
echo "Kron"
./cc.sh $(pwd)/../../datasets/kron/kron $(pwd)/stats/kron/kron $ITERATIONS 
echo "Parmat"
./cc.sh $(pwd)/../../datasets/parmat/parmat $(pwd)/stats/parmat/parmat $ITERATIONS 
echo "Soc-Livejournal"
./cc.sh $(pwd)/../../datasets/soc-livejournal/soc-LiveJournal1 $(pwd)/stats/soc_livejournal/soc-livejournal $ITERATIONS 
echo "Twitter"
./cc.sh $(pwd)/../../datasets/twitter_rv/twitter_rv $(pwd)/stats/twitter_rv/twitter_rv $ITERATIONS 

