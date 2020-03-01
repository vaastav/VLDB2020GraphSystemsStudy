#!/bin/bash

DATASET_BASE=../../datasets/cit-patents/cit-Patents
OUTFILE_BASE=stats/cit_patents/cit_patents

./pagerank.sh "${DATASET_BASE}-default_nz-gemini.bin" "${OUTFILE_BASE}-default_nz-pr.csv" 20 25 3774768 "${OUTFILE_BASE}-default_nz-cache-pr.txt"

