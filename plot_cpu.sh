#!/bin/sh

gnuplot <<EOF
 set title "OS CPU Performance"
 set terminal png truecolor
 set output "cpu.png"
 set xlabel "Time"
 set ylabel "used%"
 set grid 
plot "qps" using 3:4  with linespoints title "QPS","tps" using 3:4  with linespoints title "TPS"
EOF
