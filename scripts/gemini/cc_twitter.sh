#!/bin/bash

DATASET_BASE=../../datasets/twitter_rv/twitter_rv
OUTFILE_BASE=stats/twitter_rv/twitter_rv

./cc.sh "${DATASET_BASE}-default-gemini.bin" "${OUTFILE_BASE}-default-cc.csv" 25 61578415 "${OUTFILE_BASE}-default-cache-cc.txt"
./cc.sh "${DATASET_BASE}-degree-gemini.bin" "${OUTFILE_BASE}-degree-cc.csv" 25 41652230 "${OUTFILE_BASE}-degree-cache-cc.txt"
./cc.sh "${DATASET_BASE}-revdegree-gemini.bin" "${OUTFILE_BASE}-revdegree-cc.csv" 25 41652230 "${OUTFILE_BASE}-revdegree-cache-cc.txt"
