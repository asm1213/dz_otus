развести вланами
testClient1 <-> testServer1
testClient2 <-> testServer2

для примера посмотрим клиентов 1 и 2
* 1
  
```
5: vlan20@eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:8e:a2:a1 brd ff:ff:ff:ff:ff:ff
    inet 10.10.10.254/24 brd 10.10.10.255 scope global noprefixroute vlan20
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe8e:a2a1/64 scope link 
       valid_lft forever preferred_lft forever
```
```
[vagrant@testClient1 ~]$ ip neigh show
192.168.50.10 dev eth1 lladdr 08:00:27:5a:4d:6f STALE
10.0.2.3 dev eth0 lladdr 52:54:00:12:35:03 STALE
10.10.10.1 dev vlan20 lladdr 08:00:27:6c:dc:bd REACHABLE
10.0.2.2 dev eth0 lladdr 52:54:00:12:35:02 REACHABLE
```
* 2
```
5: vlan30@eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:21:28:8b brd ff:ff:ff:ff:ff:ff
    inet 10.10.10.254/24 brd 10.10.10.255 scope global noprefixroute vlan30
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe21:288b/64 scope link
       valid_lft forever preferred_lft forever
```
```
[vagrant@testClient2 ~]$ ip neigh show 
10.10.10.1 dev vlan30 lladdr 08:00:27:c2:82:13 REACHABLE
192.168.50.50 dev eth1 lladdr 08:00:27:35:2b:49 STALE
10.0.2.2 dev eth0 lladdr 52:54:00:12:35:02 REACHABLE
10.0.2.3 dev eth0 lladdr 52:54:00:12:35:03 STALE
```
Есть разделение на VLAN

Тест с отключение адаптера в BOND

```
4: eth2: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master bond0 state UP group default qlen 1000
    link/ether 08:00:27:70:df:ed brd ff:ff:ff:ff:ff:ff
5: eth3: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master bond0 state UP group default qlen 1000
    link/ether 08:00:27:b5:80:57 brd ff:ff:ff:ff:ff:ff
7: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:70:df:ed brd ff:ff:ff:ff:ff:ff
    inet 192.168.40.10/24 brd 192.168.40.255 scope global bond0
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe70:dfed/64 scope link
       valid_lft forever preferred_lft forever
```
отключим eth3
``` sudo ip link set eth3 down ```
```
5: eth3: <BROADCAST,MULTICAST,SLAVE> mtu 1500 qdisc pfifo_fast master bond0 state DOWN group default qlen 1000
    link/ether 08:00:27:b5:80:57 brd ff:ff:ff:ff:ff:ff
```
проверим доступность inetRouter
```
[vagrant@centralRouter ~]$ ping 192.168.40.11
PING 192.168.40.11 (192.168.40.11) 56(84) bytes of data.
64 bytes from 192.168.40.11: icmp_seq=1 ttl=64 time=0.611 ms
64 bytes from 192.168.40.11: icmp_seq=2 ttl=64 time=0.362 ms
64 bytes from 192.168.40.11: icmp_seq=3 ttl=64 time=0.373 ms
```
Эхо сигнал проходит
