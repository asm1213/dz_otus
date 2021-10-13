равести вланами
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
