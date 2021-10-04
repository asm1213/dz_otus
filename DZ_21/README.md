
# ДЗ 21 OPENVPN
## TUN и TAP
### в папках tun и tap соотвествующие стенды
Основноное отличие это работа на разных уровнях OSI tap - l2, tun -l3
TAP - броадкасты, arp, подходит для бриджа
TUN - для  


## Генерация ключей и сертификатов
### gen CA
```
openssl genrsa -out ca.key 4096
openssl req -new -x509 -days 365 -key ca.key -out ca.crt
```
### gen srv 
```
openssl genrsa -out server.key 4096
openssl req -new -key server.key -out server.csr
openssl x509 -req -days 365  -CA ca.crt -CAkey ca.key -set_serial 01 -extensions req_ext -in server.csr -out server.crt
```
### gen client 
```
openssl genrsa -out client.key 4096
openssl req -new -key client.key -out client.csr
openssl x509 -req -days 365  -CA ca.crt -CAkey ca.key -set_serial 01 -extensions req_ext -in client.csr -out client.crt
```
### Diffie hellman pem
```
openssl dhparam -out dhparams.pem 2048
```
Для клиента на windows скачал клиент версии 3, в файле client.conf интегрировал сертификаты и изменил расширение на ovpn.
Подключение прошло

![Иллюстрация к проекту](https://github.com/asm1213/dz_otus/blob/main/DZ_21/ras/pic1.png)