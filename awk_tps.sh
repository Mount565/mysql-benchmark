#!/bin/sh
awk '
   BEGIN {
      printf "#ts date time TPS";
      fmt = " %.2f";
  }
  /^TS/ {
     ts = substr($2,1,index($2,".") - 1);
     diff = ts - prev_ts;
     prev_ts = ts;
     printf "\n%s %s %s",ts,$3,$4;
  }
  /Com_commit/ {
   cc=$2;
  }

  /Com_rollback[^_]/ {
   tt = cc + $2;
   printf fmt, (tt-prev_tt)/diff;
   prev_tt =  tt;
 
  }

' "$@"
