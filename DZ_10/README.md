# DZ_10
Файл nice.sh 

2 процеса архивируют один и тот же файл созданный DD 
один с nice 20, другой -20.
результат ниже

```
[vagrant@proc /]$ sudo ./vagrant/nice.sh
1+0 records in
1+0 records out
128000000 bytes (128 MB) copied, 2.99046 s, 42.8 MB/s
HI 10
LOW 21
```