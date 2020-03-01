#!/bin/bash

echo "Cit Patents"
./sha256dataset.sh ../datasets/cit-patents/cit-Patents.net ../dataset_sums/cit_patents.sha
echo "Soc Livejournal"
./sha256dataset.sh ../datasets/soc-livejournal/soc-LiveJournal1.net ../dataset_sums/soc_livejournal.sha
echo "Twitter_rv"
./sha256dataset.sh ../datasets/twitter_rv/twitter_rv.net ../dataset_sums/twitter_rv.sha
