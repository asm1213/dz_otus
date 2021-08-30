#!/bin/bash

tmlast=$(tail -n1 /var/tmp/parstime.log ) #время предыдущего запуска

tmstart=$(date +%F"T"%T) #время запуска

TT=$(date -d $tmlast +%s)  #время предыдущего запуска в сек

vagrant/accesscho $tmstart >> /var/tmp/parstime.log #передача даты последнего запуска для последующих выполнений

# Строки из лога с момента последнего запуска перенаправлены в переменную
logpars=$(
cat /vagrant/access.log |
sed 's/\//-/1' | #замена первого разделителя даты / на -
sed 's/\//-/1' | #замена второго разделителя даты / на -
sed 's/\:/T/1' | #замена разделителя даты и времени : на T,  его понимает команда date
sed 's/\[//1'  | #убрал скобку [ c даты
awk '{cmd="date -d "$4" +%s"; cmd | getline x; close(cmd);$4=x;print $0}' | # время в секундах в 4 поле, в логе
awk -v DD=$TT '$4 > DD {print}') #вывод строк дата которых больше заданной даты

logmail=$(
echo "Лог с " $tmlast "до" $tmstart
echo "Топ 10 IP"
echo "$logpars" | cut -f 1 -d ' ' | sort | uniq -c | sort -n -r | sed -n "1,10 p" 
echo "Top 10 адрессов"
echo "$logpars" | cut -f 7 -d ' ' | sort | uniq -c | sort -n -r | sed -n "1,10 p" 
echo "Все коды возврата"
echo "$logpars" | cut -f 9 -d ' ' | sort | uniq -c | sort -n -r
echo "все ошибки"
echo "$logpars" | awk '$9 != "200"' )

echo "$logmail" | mailx -s "Log from $tmstart" root@localhost