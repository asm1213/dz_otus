
# 

# Генерация ключей и сертификатов
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

