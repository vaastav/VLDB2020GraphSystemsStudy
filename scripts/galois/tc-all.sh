#!/bin/bash

ITERATIONS=25

./triangle-counting.sh ../../datasets/cit-patents/cit-Patents stats/cit_patents/cit_patents $ITERATIONS 
./triangle-counting.sh ../../datasets/kron/kron stats/kron/kron $ITERATIONS 
./triangle-counting.sh ../../datasets/parmat/parmat stats/parmat/parmat $ITERATIONS 
./triangle-counting.sh ../../datasets/soc-livejournal/soc-LiveJournal1 stats/soc_livejournal/soc-livejournal $ITERATIONS 

