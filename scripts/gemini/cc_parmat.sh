#!/bin/bash

DATASET_BASE=../../datasets/parmat/parmat
OUTFILE_BASE=stats/parmat/parmat

./cc.sh "${DATASET_BASE}-default-gemini.bin" "${OUTFILE_BASE}-default-cc.csv" 25 65482 "${OUTFILE_BASE}-default-cache-cc.txt"
./cc.sh "${DATASET_BASE}-degree-gemini.bin" "${OUTFILE_BASE}-degree-cc.csv" 25 48501 "${OUTFILE_BASE}-degree-cache-cc.txt"
./cc.sh "${DATASET_BASE}-revdegree-gemini.bin" "${OUTFILE_BASE}-revdegree-cc.csv" 25 48501 "${OUTFILE_BASE}-revdegree-cache-cc.txt"

