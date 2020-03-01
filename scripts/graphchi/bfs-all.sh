#!/bin/bash

ITERATIONS=25

./bfs.sh ../datasets/cit-patents/cit-Patents stats/cit_patents/cit_patents $ITERATIONS 
./bfs.sh ../datasets/kron/kron stats/kron/kron $ITERATIONS 
./bfs.sh ../datasets/parmat/parmat stats/parmat/parmat $ITERATIONS 
./bfs.sh ../datasets/soc-livejournal/soc-LiveJournal1 stats/soc_livejournal/soc-livejournal $ITERATIONS 
./bfs.sh ../datasets/twitter_rv/twitter_rv stats/twitter_rv/twitter_rv $ITERATIONS 
