#!/bin/sh

sysbench_cmd=`which sysbench`

RUNFILE=/tmp/benchmark-running

c=`grep 'no sysbench' sysbench_cmd | wc -l`

if [[ $c>0 ]];then
  echo ${sysbench_cmd}
  exit;

fi

nohup ./capture.sh &

touch $RUNFILE

${sysbench_cmd} $@

rm -f $RUNFILE

