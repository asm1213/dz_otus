# Домашнее задание 26
## репликация postgres
```
настроить hot_standby репликацию с использованием слотов
настроить правильное резервное копирование
Для сдачи работы присылаем ссылку на репозиторий, в котором должны обязательно быть 

Vagranfile (2 машины)
плейбук Ansible
конфигурационные файлы postgresql.conf, pg_hba.conf и recovery.conf,
конфиг barman, либо скрипт резервного копирования.
Команда "vagrant up" должна поднимать машины с настроенной репликацией и резервным копированием. 
Рекомендуется в README.md файл вложить результаты (текст или скриншоты) проверки работы репликации и резервного копирования.
```

мастер

```
postgres=# select * from pg_stat_replication;
-[ RECORD 1 ]----+------------------------------
pid              | 5513
usesysid         | 16385
usename          | repuser
application_name | walreceiver
client_addr      | 192.168.10.11
client_hostname  |
client_port      | 53422
backend_start    | 2021-11-19 18:41:32.250467+00
backend_xmin     |
state            | streaming
sent_lsn         | 0/5025E28
write_lsn        | 0/5025E28
flush_lsn        | 0/5025E28
replay_lsn       | 0/5025E28
write_lag        | 00:00:00.005169
flush_lag        | 00:00:00.007494
replay_lag       | 00:00:00.009241
sync_priority    | 0
sync_state       | async
reply_time       | 2021-11-19 18:51:29.528193+00
```

создал таблицу
```
postgres=# CREATE TABLE customers
postgres-# (
postgres(#     Id SERIAL PRIMARY KEY,
postgres(#     FirstName CHARACTER VARYING(30),
postgres(#     LastName CHARACTER VARYING(30),
postgres(#     Email CHARACTER VARYING(30),
postgres(#     Age INTEGER
postgres(# );
```
проверим на slave
```
postgres=# \dt
           List of relations
 Schema |   Name    | Type  |  Owner
--------+-----------+-------+----------
 public | customers | table | postgres
(1 row)
```