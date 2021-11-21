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
добавил в нее пару записей
```
postgres=# INSERT INTO customers VALUES (1, 'serg','art','1@1.com', 15);
postgres=# INSERT INTO customers VALUES (1, 'srg','at','21@1.com', 125);
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

** **
## BARMAN
Настраивал стрим репликацию.
пользователь barman superuser в постгрес.
Рекомендация из мануала. 
Для работы репликации в $PATH barman и postgres добален /usr/pgsql-14/bin/
иначе не запускается pg_receivewal

Чтобы не ждать смены wal файла и проверить настройки сделаем это принудительно
``` 
barman switch-xlog --force --archive master 
```

сделаем бэкап
```
bash-4.2$ barman backup master
Starting backup using postgres method for server master in /var/lib/barman/master/base/20211121T135647
Backup start at LSN: 0/A000060 (00000001000000000000000A, 00000060)
Starting backup copy via pg_basebackup for 20211121T135647
Copy done (time: 5 seconds)
Finalising the backup.
This is the first backup for server master
WAL segments preceding the current backup have been found:
        000000010000000000000009 from server master has been removed
Backup size: 33.3 MiB
Backup end at LSN: 0/C000000 (00000001000000000000000B, 00000000)
Backup completed (start time: 2021-11-21 13:56:47.930269, elapsed time: 7 seconds)
Processing xlog segments from streaming for master
        00000001000000000000000A
        00000001000000000000000B
```
проверим сервер
```
bash-4.2$ barman check master
Server master:
        PostgreSQL: OK
        superuser or standard user with backup privileges: OK
        PostgreSQL streaming: OK
        wal_level: OK
        replication slot: OK
        directories: OK
        retention policy settings: OK
        backup maximum age: OK (no last_backup_maximum_age provided)
        compression settings: OK
        failed backups: OK (there are 0 failed backups)
        minimum redundancy requirements: OK (have 1 backups, expected at least 1)
        pg_basebackup: OK
        pg_basebackup compatible: OK
        pg_basebackup supports tablespaces mapping: OK
        systemid coherence: OK
        pg_receivexlog: OK
        pg_receivexlog compatible: OK
        receive-wal running: OK
        archiver errors: OK
```