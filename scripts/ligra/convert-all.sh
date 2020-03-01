#!/bin/bash
#set -e

echo "Cit-patents"
./convert.sh $(pwd)/../../datasets/cit-patents/cit-Patents
echo "Kron"
./convert.sh $(pwd)/../../datasets/kron/kron
echo "Parmat"
./convert.sh $(pwd)/../../datasets/parmat/parmat 
echo "Soc-Livejournal"
./convert.sh $(pwd)/../../datasets/soc-livejournal/soc-LiveJournal1 
echo "Twitter"
./convert.sh $(pwd)/../../datasets/twitter_rv/twitter_rv
