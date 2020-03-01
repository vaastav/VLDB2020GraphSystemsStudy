#!/bin/bash

DATASET_BASE=../../datasets/cit-patents/cit-Patents
OUTFILE_BASE=stats/cit_patents/cit_patents

./cc.sh "${DATASET_BASE}-default_nz-gemini.bin" "${OUTFILE_BASE}-default-cc.csv" 25 3774768 "${OUTFILE_BASE}-default_nz-cache-cc.txt"
./cc.sh "${DATASET_BASE}-degree-gemini.bin" "${OUTFILE_BASE}-degree-cc.csv" 25 3774768 "${OUTFILE_BASE}-degree-cache-cc.txt"
./cc.sh "${DATASET_BASE}-revdegree-gemini.bin" "${OUTFILE_BASE}-revdegree-cc.csv" 25 3774768 "${OUTFILE_BASE}-revdegree-cache-cc.txt"

