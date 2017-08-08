#!/bin/sh

gnuplot <<EOF
 set title "MySQL Performance TPS/QPS"
 set terminal png truecolor
 set output "mysql_tps.png"
 set xdata time
 set timefmt "%H:%M:%S"
 set format x "%H:%M:%S"
set xlabel "Time"
set ylabel "QPS/TPS"
 set grid 
plot "qps" using 3:4  with linespoints title "QPS","tps" using 3:4  with linespoints title "TPS"

EOF
