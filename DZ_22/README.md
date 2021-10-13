# ДЗ сплит DNS
Запустить стенд ``` vagrant up ```
для проверки работоспособности сплит dns проверим, 
работают ли DNS серверы в соотвествии с исходными данными.

* клиент1 - видит обе зоны, но в зоне dns.lab только web1.

проверим:
```
[vagrant@client ~]$ nslookup web1 
Server:         192.168.50.10
Address:        192.168.50.10#53

Name:   web1.dns.lab
Address: 192.168.50.15
```
```
[vagrant@client ~]$ nslookup web2
;; Got SERVFAIL reply from 192.168.50.10, trying next server
Server:         192.168.50.11
Address:        192.168.50.11#53

** server can't find web2: SERVFAIL
```
```
[vagrant@client ~]$ nslookup www.newdns.lab
Server:         192.168.50.10
Address:        192.168.50.10#53

Name:   www.newdns.lab
Address: 192.168.50.15
Name:   www.newdns.lab
Address: 192.168.50.16
```
* клиент2 видит только dns.lab
```
[vagrant@client2 ~]$ nslookup www.newdns.lab
;; Got SERVFAIL reply from 192.168.50.10, trying next server
Server:         192.168.50.10
Address:        192.168.50.10#53

** server can't find www.newdns.lab: NXDOMAIN
```
```
[vagrant@client2 ~]$ nslookup web1
Server:         192.168.50.10
Address:        192.168.50.10#53

Name:   web1.dns.lab
Address: 192.168.50.15
```
```
[vagrant@client2 ~]$ nslookup web2
Server:         192.168.50.10
Address:        192.168.50.10#53

Name:   web2.dns.lab
Address: 192.168.50.16
```