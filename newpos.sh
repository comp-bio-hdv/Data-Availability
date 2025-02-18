#!/bin/bash

cat ACTAT_perms | 
while read LINE
do
grep -l GTTC 1_* | xargs grep $LINE > ./store/BOTH_SL1_AMBER_$LINE
awk -v PERM="$LINE" -f newpos.awk ./store/BOTH_SL1_AMBER_$LINE | sort -t: -nk3 > ./store/BOTH_SL1_AMBER_DIST_$LINE
done
