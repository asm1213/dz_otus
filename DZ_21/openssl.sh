openssl genrsa -out server.key 4096
   37  openssl req -new -key server.key -out server.csr
   38  openssl x509 -req -days 365  -CA ca.crt -CAkey ca.key -set_serial 01 -extfile openssl-csr.cnf -extensions req_ext -in server.csr -out server.crt
   39  openssl x509 -req -days 365  -CA ca.crt -CAkey ca.key -set_serial 01 -extensions req_ext -in server.csr -out server.crt
   40  ls
   41  vi server.crt
   42  openssl dhparam -out dhparams.pem 2048
   43  ls
   44  history