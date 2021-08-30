# DZ_4
Homework #4
### часть1
Создал пул из 2 физ дисков в зеркале
```
sudo zpool create mypool mirror sdc sdd
```
Создал 5 файловых систем с 5 видами компрессии
```
sudo zfs create -o compression=gzip-9 mypool/zfs1
sudo zfs create -o compression=gzip mypool/zfs2
sudo zfs create -o compression=lzjb mypool/zfs3
sudo zfs create -o compression=zle mypool/zfs4
sudo zfs create -o compression=lz4 mypool/zfs5
```
Скачал и скопировал файл на 5 фс.
```
sudo curl -o "War_and_Peace.txt" -J -L https://www.gutenberg.org/cache/epub/2600/pg2600.txt
cp mypool/zfs2/War_and_Peace.txt mypool/zfs1
cp mypool/zfs2/War_and_Peace.txt mypool/zfs3
cp mypool/zfs2/War_and_Peace.txt mypool/zfs4
sudo cp mypool/zfs2/War_and_Peace.txt mypool/zfs5
```
На предложенном файле трудно сделать вывод, так как уровень сжатия одинаков, 
по умолчанию используется lzjb наименее затратный по ресурсам и с наименьшей степенью сжатия, если нужно максимум то, gzip-9. 
выводы команд в логе part1.log
### часть2
скачал указанный файл с google drive
```
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1KRBNW33QWqbvbVHa3hLJivOAt60yukkg' -O zfs_task1.tar.gz
```
распаковал архив
```
tar xvzf zfs_task1.tar.gz
```
выполнил 
```
zpool import -d filea -d fileb otus
```
проверил статус пула
получил
```
 pool: otus
 state: ONLINE
  scan: none requested
config:

        NAME                                STATE     READ WRITE CKSUM
        otus                                ONLINE       0     0     0
          mirror-0                          ONLINE       0     0     0
            /mypool/zfs1/zpoolexport/filea  ONLINE       0     0     0
            /mypool/zfs1/zpoolexport/fileb  ONLINE       0     0     0

```
Пул собран из зеркала
```
zfs list
otus            2.04M   350M       24K  /otus
```
сжатие и его алгоритм
```
zfs get compressratio,compression
otus            compression    zle       local
otus            compressratio  1.00x     -
otus/hometask2  compression    zle       inherited from otus
otus/hometask2  compressratio  1.00x     -
```
чек сумма
```
zfs get checksum otus
NAME  PROPERTY  VALUE      SOURCE
otus  checksum  sha256     local
```
recordsize
```
zfs get recordsize otus
NAME  PROPERTY    VALUE    SOURCE
otus  recordsize  128K     local
```
логи 2 части в файле part2.log

### часть3
полуцчил файл
```
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1gH8gCL9y7Nd5Ti3IRmplZPF1XjzxeRAG' -O otus_task2.file
```
восстановил 
```
zfs create /mypool/zfs3/restore
zfs receive mypool/zfs3/restore < otus_task2.file
cd /mypool/zfs3/restore/
dir
10M.file  Limbo.txt  Moby_Dick.txt  War_and_Peace.txt  cinderella.tar  for_examaple.txt  homework4.txt  task1  world.sql
```
поиск файла в востановленном снапшете
```
find /mypool/zfs3/ -name *secret*
```
файла secret_message
содержит ссылку
```
https://github.com/sindresorhus/awesome
```
лог в part3.log

# Конец
