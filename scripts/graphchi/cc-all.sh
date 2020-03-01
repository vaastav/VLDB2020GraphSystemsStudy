#!/bin/bash
#set -e
COUNTS=25

#echo "Cit-patents"
#./cc.sh $(pwd)/../../datasets/cit-patents/cit-Patents $(pwd)/stats/cit_patents/cit_patents $COUNTS 
#echo "Kron"
#./cc.sh $(pwd)/../../datasets/kron/kron $(pwd)/stats/kron/kron $COUNTS 
echo "Parmat"
./cc.sh $(pwd)/../../datasets/parmat/parmat $(pwd)/stats/parmat/parmat $COUNTS 
echo "Soc-Livejournal"
./cc.sh $(pwd)/../../datasets/soc-livejournal/soc-LiveJournal1 $(pwd)/stats/soc_livejournal/soc-livejournal $COUNTS 
echo "Twitter"
./cc.sh $(pwd)/../../datasets/twitter_rv/twitter_rv $(pwd)/stats/twitter_rv/twitter_rv $COUNTS 

