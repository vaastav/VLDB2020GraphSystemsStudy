#!/bin/bash

DATASET_BASE=../../datasets/kron/kron
OUTFILE_BASE=stats/kron/kron

./pagerank.sh "${DATASET_BASE}-default-gemini.bin" "${OUTFILE_BASE}-default-pr.csv" 20 25 393092 "${OUTFILE_BASE}-default-cache-pr.txt"
./pagerank.sh "${DATASET_BASE}-degree-gemini.bin" "${OUTFILE_BASE}-degree-pr.csv" 20 25 334279 "${OUTFILE_BASE}-degree-cache-pr.txt"
./pagerank.sh "${DATASET_BASE}-revdegree-gemini.bin" "${OUTFILE_BASE}-revdegree-pr.csv" 20 25 334279 "${OUTFILE_BASE}-revdegree-cache-pr.txt"
