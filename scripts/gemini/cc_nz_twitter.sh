#!/bin/bash

DATASET_BASE=../../datasets/twitter_rv/twitter_rv
OUTFILE_BASE=stats/twitter_rv/twitter_rv

./cc.sh "${DATASET_BASE}-default_nz-gemini.bin" "${OUTFILE_BASE}-default_nz-cc.csv" 10 41652230 "${OUTFILE_BASE}-default_nz-cache-cc.txt"
