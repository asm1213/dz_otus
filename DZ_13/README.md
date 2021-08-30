# DZ_13
selinux

установил утилиты для работы с selinux

`yum install policycoreutils-python setroubleshoot`

# Задание 1

В конфиге nginx поменял порт на 8099

выполнил `systemctl start nginx`

получил 

```Job for nginx.service failed because the control process exited with error code. See "systemctl status nginx.service" and "journalctl -xe" for details.```

выполнил 

`sealert -a /var/log/audit/audit.log`

Итак, 

## вариант 1

выполнил команду
`setsebool -P httpd_run_preupgrade 1`

проверил запуск сервиса nginx, он заработал

## варинат 2

выполнил команду 

`semanage port -l |grep 80`

нашел 

`http_port_t  tcp  80, 81, 443, 488, 8008, 8009, 8443, 9000`

выполнил

`semanage port -m -t http_port_t -p tcp 8099`

получил 

```
http_port_t  tcp 8099, 80, 81, 443, 488, 8008, 8009, 8443, 9000

systemctl start nginx

systemctl status nginx.service

 nginx.service - The nginx HTTP and reverse proxy server
 
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; vendor preset: disabled)
   
   Active: active (running) since Sat 2021-07-03 13:31:21 UTC; 11s ago
   
  Process: 2601 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  
  Process: 2598 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  
  Process: 2597 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
  
 Main PID: 2603 (nginx)
 
   CGroup: /system.slice/nginx.service
   
           ├─2603 nginx: master process /usr/sbin/nginx
           
           └─2604 nginx: worker process
```
           
## вариант 3
создаем модуль
```
ausearch -c 'nginx' --raw | audit2allow -M my-nginx 
semodule -i my-nginx.pp
```
запустил и проверил работу nginx


лог терминала в файле shell.log

# Задание  2
выбрал вариант с 
```
setsebool named_write_master_zones on
```
он позваолит named менять зоны. Не только приведенную в стенде, но и другие , это понадобится для днс сервера. 
можно было ограничиться правами на зону поменяв контекст named.ddns.lab.view1.jnl

chapter2.log
