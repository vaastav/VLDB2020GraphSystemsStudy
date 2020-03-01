#!/bin/bash

DATASET_BASE=../../datasets/twitter_rv/twitter_rv
OUTFILE_BASE=stats/twitter_rv/twitter_rv

./pagerank.sh "${DATASET_BASE}-default_nz-gemini.bin" "${OUTFILE_BASE}-default_nz-pr.csv" 20 1 61578415 "${OUTFILE_BASE}-default_nz-cache-pr.txt"
