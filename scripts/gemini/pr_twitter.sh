#!/bin/bash

DATASET_BASE=../../datasets/twitter_rv/twitter_rv
OUTFILE_BASE=stats/twitter_rv/twitter_rv

./pagerank.sh "${DATASET_BASE}-default-gemini.bin" "${OUTFILE_BASE}-default-pr.csv" 20 25 61578415 "${OUTFILE_BASE}-default-cache-pr.txt"
./pagerank.sh "${DATASET_BASE}-degree-gemini.bin" "${OUTFILE_BASE}-degree-pr.csv" 20 25 41652230 "${OUTFILE_BASE}-degree-cache-pr.txt"
./pagerank.sh "${DATASET_BASE}-revdegree-gemini.bin" "${OUTFILE_BASE}-revdegree-pr.csv" 20 25 41652230 "${OUTFILE_BASE}-revdegree-cache-pr.txt"
