#!/bin/bash

DATASET=$1
OUTFILE=$2

sha256sum $DATASET > $OUTFILE
