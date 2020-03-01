#!/bin/bash

DATASET_BASE=../../datasets/soc-livejournal/soc-LiveJournal1
OUTFILE_BASE=stats/soc_livejournal/soc-livejournal

./cc.sh "${DATASET_BASE}-default-gemini.bin" "${OUTFILE_BASE}-default-cc.csv" 25 4847571 "${OUTFILE_BASE}-default-cache-cc.txt"
./cc.sh "${DATASET_BASE}-degree-gemini.bin" "${OUTFILE_BASE}-degree-cc.csv" 25 4847571 "${OUTFILE_BASE}-degree-cache-cc.txt"
./cc.sh "${DATASET_BASE}-revdegree-gemini.bin" "${OUTFILE_BASE}-revdegree-cc.csv" 25 4847571 "${OUTFILE_BASE}-revdegree-cache-cc.txt"
