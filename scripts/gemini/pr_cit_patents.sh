#!/bin/bash

DATASET_BASE=../../datasets/cit-patents/cit-Patents
OUTFILE_BASE=stats/cit_patents/cit_patents

./pagerank.sh "${DATASET_BASE}-default-gemini.bin" "${OUTFILE_BASE}-default-pr.csv" 20 25 6009555 "${OUTFILE_BASE}-default-cache-pr.txt"
./pagerank.sh "${DATASET_BASE}-degree-gemini.bin" "${OUTFILE_BASE}-degree-pr.csv" 20 25 3774768 "${OUTFILE_BASE}-degree-cache-pr.txt"
./pagerank.sh "${DATASET_BASE}-revdegree-gemini.bin" "${OUTFILE_BASE}-revdegree-pr.csv" 20 25 3774768 "${OUTFILE_BASE}-revdegree-cache-pr.txt"

