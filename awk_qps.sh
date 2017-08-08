#!/bin/sh
awk '
   BEGIN {
      printf "#ts date time QPS";
      fmt = " %.2f";
  }
  /^TS/ {
     ts = substr($2,1,index($2,".") - 1);
     diff = ts - prev_ts;
     prev_ts = ts;
     printf "\n%s %s %s",ts,$3,$4;
  }
  /Queries/ {
   printf fmt, ($2-Queries)/diff;
   Queries=$2;
  }
' "$@"
