# Теоритическая часть 

1. Свободных подсетей огромное количество, нужно больше входных данных.
2. Информация приведена ниже.
3. Информация приведена ниже.
4. Подсети не пересекаются, ошибок нет. 


# сеть офис1

## dev
```
IP Address:	192.168.2.0
Network Address:	192.168.2.0
Usable Host IP Range:	192.168.2.1 - 192.168.2.62
Broadcast Address:	192.168.2.63
Total Number of Hosts:	64
Number of Usable Hosts:	62
Subnet Mask:	255.255.255.192
Wildcard Mask:	0.0.0.63
```
## test servers
```
IP Address:	192.168.2.64
Network Address:	192.168.2.64
Usable Host IP Range:	192.168.2.65 - 192.168.2.126
Broadcast Address:	192.168.2.127
Total Number of Hosts:	64
Number of Usable Hosts:	62
Subnet Mask:	255.255.255.192
Wildcard Mask:	0.0.0.63
```
## managers
```
IP Address:	192.168.2.128
Network Address:	192.168.2.128
Usable Host IP Range:	192.168.2.129 - 192.168.2.190
Broadcast Address:	192.168.2.191
Total Number of Hosts:	64
Number of Usable Hosts:	62
Subnet Mask:	255.255.255.192
Wildcard Mask:	0.0.0.63
```
## office hardware
```
IP Address:	192.168.2.192
Network Address:	192.168.2.192
Usable Host IP Range:	192.168.2.193 - 192.168.2.254
Broadcast Address:	192.168.2.255
Total Number of Hosts:	64
Number of Usable Hosts:	62
Subnet Mask:	255.255.255.192
Wildcard Mask:	0.0.0.63
```
# Сеть офис2

## dev
```
IP Address:	192.168.1.0
Network Address:	192.168.1.0
Usable Host IP Range:	192.168.1.1 - 192.168.1.126
Broadcast Address:	192.168.1.127
Total Number of Hosts:	128
Number of Usable Hosts:	126
Subnet Mask:	255.255.255.128
Wildcard Mask:	0.0.0.127
```
## test servers
```
IP Address:	192.168.1.128
Network Address:	192.168.1.128
Usable Host IP Range:	192.168.1.129 - 192.168.1.190
Broadcast Address:	192.168.1.191
Total Number of Hosts:	64
Number of Usable Hosts:	62
Subnet Mask:	255.255.255.192
Wildcard Mask:	0.0.0.63
```
## office hardware
```
IP Address:	192.168.1.192
Network Address:	192.168.1.192
Usable Host IP Range:	192.168.1.193 - 192.168.1.254
Broadcast Address:	192.168.1.255
Total Number of Hosts:	64
Number of Usable Hosts:	62
Subnet Mask:	255.255.255.192
Wildcard Mask:	0.0.0.63
```

# Сеть central
## directors
```
IP Address:	192.168.0.0
Network Address:	192.168.0.0
Usable Host IP Range:	192.168.0.1 - 192.168.0.14
Broadcast Address:	192.168.0.15
Total Number of Hosts:	16
Number of Usable Hosts:	14
Subnet Mask:	255.255.255.240
Wildcard Mask:	0.0.0.15
```
## office hardware
```
IP Address:	192.168.0.32
Network Address:	192.168.0.32
Usable Host IP Range:	192.168.0.33 - 192.168.0.46
Broadcast Address:	192.168.0.47
Total Number of Hosts:	16
Number of Usable Hosts:	14
Subnet Mask:	255.255.255.240
Wildcard Mask:	0.0.0.15
```
## wifi
```
IP Address:	192.168.0.64
Network Address:	192.168.0.64
Usable Host IP Range:	192.168.0.65 - 192.168.0.126
Broadcast Address:	192.168.0.127
Total Number of Hosts:	64
Number of Usable Hosts:	62
Subnet Mask:	255.255.255.192
Wildcard Mask:	0.0.0.63
```

Реализовал схему
![Иллюстрация к проекту](https://github.com/asm1213/dz_otus/blob/main/DZ_17/net.jpg)

при желании можно добавить дополнительный оффис.
