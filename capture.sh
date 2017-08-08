#!/bin/sh

INTERVAL=5
PREFIX=$INTERVAL-sec-status
RUNFILE=/tmp/benchmark-running

db_user=test
db_pass=test
db_host=172.18.0.68


nohup iostat -m ${INTERVAL} > iostat.data &

iostat_pid=$!

mysql -u$db_user -p${db_pass}  -h$db_host -e "show global variables" > mysql-variables

while test -e $RUNFILE; do 
	file=$(date +%F)
	sleep=$(date +%s.%N | awk "{print $INTERVAL -(\$1 % $INTERVAL)}")
	sleep $sleep
	ts="$(date +"TS %s.%N %F %T")"
	loadavg="$(uptime)"

	echo "$ts $loadavg" >> $PREFIX-${file}-status
	mysql -u$db_user -p$db_pass -h$db_host -e "SHOW GLOBAL STATUS" >> $PREFIX-${file}-status

	echo "$ts $loadavg" >> $PREFIX-${file}-innodbstatus
	mysql -u$db_user -p$db_pass -h$db_host -e "SHOW ENGINE INNODB STATUS\G" >> $PREFIX-${file}-innodbstatus

	echo "$ts $loadavg" >> $PREFIX-${file}-processlist
        mysql -u$db_user -p$db_pass -h$db_host -e "SHOW FULL PROCESSLIST\G" >> $PREFIX-${file}-processlist
done

kill -9 $iostat_pid

echo Exiting because $RUNFILE does not exit.
