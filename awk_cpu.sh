#!/bin/sh

echo '#avg-cpu:  %user   %nice %system %iowait  %steal   %idle' 

awk '{a[NR]=$0;if(a[NR-1]~/^avg-cpu:/){print a[NR]}}' $@
