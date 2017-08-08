# mysql-benchmark
Benchmark mysql using sysbench and meanwhile capture the mysql status,system load, iostates and plotting using the these data.


sysbench.sh encapsulate sysbench command, it accepts any options that go with sysbench, you can treat it like sysbench:
```Bash
./sysbench.sh --test=oltp.lua --mysql-host=172.18.0.68  --mysql-port=3306 --mysql-user=test --mysql-password=test  --mysql-db=test --oltp-tables-count=1 --oltp-table-size=1000000 --report-interval=10  --oltp-read-only=off --max-time=1200 --max-requests=0 --num-threads=100 run
```
capture.sh program captures system load, mysql status, and iostat information while sysbenching. when sysbench finishs , a Running file is deleted , this will cause the capture program to stop automatically.

awk_tps.sh and awk_qps.sh help to prepare plotting data for TPS and QPS. these 2 programs are used against mysql status data, like:

```Bash
./awk_tps.sh 5-sec-status-2017-08-08-status > tps 
./awk_qps.sh 5-sec-status-2017-08-08-status > qps
./awk_cpu.sh iostat.data > cpu 
```
You can also write other awk scripts to prepare plotting data for other metrics.

