# Домашнее задание OSPF

схема сети
![Иллюстрация к проекту](https://github.com/asm1213/dz_otus/blob/main/DZ_20/net.png)

Стенд сконфигурирован с симметричным роутингом. 
Таблица маршрутизации на vm1 получилась

```
[vagrant@vm1 ~]$ ip route
default via 10.0.2.2 dev eth0 proto dhcp metric 100
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 metric 100
192.168.10.0/24 dev vlan10 proto kernel scope link src 192.168.10.10 metric 401 
192.168.20.0/24 proto ospf metric 20
        nexthop via 192.168.10.11 dev vlan10 weight 1
        nexthop via 192.168.30.10 dev vlan30 weight 1
192.168.30.0/24 dev vlan30 proto kernel scope link src 192.168.30.11 metric 400 
```
traceroute 
```
[vagrant@vm1 ~]$ traceroute 192.168.20.10
traceroute to 192.168.20.10 (192.168.20.10), 30 hops max, 60 byte packets
 1  192.168.20.10 (192.168.20.10)  8.110 ms  4.750 ms  4.140 ms
 ```
 после изменение стоимости интерфейса vlan10 на vm1 = 555
 ```
 [vagrant@vm1 ~]$ traceroute 192.168.20.10
traceroute to 192.168.20.10 (192.168.20.10), 30 hops max, 60 byte packets
 1  192.168.30.10 (192.168.30.10)  11.374 ms  4.233 ms  2.809 ms
 2  192.168.20.10 (192.168.20.10)  5.518 ms  5.362 ms  5.139 ms
 ```