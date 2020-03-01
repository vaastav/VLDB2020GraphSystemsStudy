#!/bin/bash

DATASET_BASE=../../datasets/kron/kron
OUTFILE_BASE=stats/kron/kron

./cc.sh "${DATASET_BASE}-default-gemini.bin" "${OUTFILE_BASE}-default-cc.csv" 25 393092 "${OUTFILE_BASE}-default-cache-cc.txt"
./cc.sh "${DATASET_BASE}-degree-gemini.bin" "${OUTFILE_BASE}-degree-cc.csv" 25 334279 "${OUTFILE_BASE}-degree-cache-cc.txt"
./cc.sh "${DATASET_BASE}-revdegree-gemini.bin" "${OUTFILE_BASE}-revdegree-cc.csv" 25 334279 "${OUTFILE_BASE}-revdegree-cache-cc.txt"
