REM Generate self signed root CA cert
openssl req -nodes -x509 -newkey rsa:2048 -keyout ca.key -out ca.crt -subj "/C=SG/ST=DA/L=Singapore/O=MongoDB/OU=root/CN=mongo.example"


REM Generate server cert to be signed
openssl req -nodes -newkey rsa:2048 -keyout server.key -out server.csr -subj "/C=SG/ST=DA/L=Singapore/O=MongoDB/OU=root/CN=mongo.example"

REM Sign the server cert
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt

REM Create server PEM file
cat server.key server.crt > server.pem


REM Generate client cert to be signed
openssl req -nodes -newkey rsa:2048 -keyout client.key -out client.csr -subj "/C=SG/ST=DA/L=Singapore/O=MongoDB/OU=root/CN=mongo.example"

REM Sign the client cert
openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAserial ca.srl -out client.crt

REM Create client PEM file
cat client.key client.crt > client.pem


REM Create clientPFX file (for Java, C#, etc)
openssl pkcs12 -inkey client.key -in client.crt -export -out client.pfx
REM keytool -import -alias compose -file ./ca.crt -keystore ./javaclient -storetype pkcs12 -storepass password

REM Start mongod with SSL
REM mkdir -p data/db
REM mongod --sslMode requireSSL --sslPEMKeyFile server.pem --sslCAFile ca.crt --dbpath data/db --logpath data/mongod.log --fork

REM Connect to mongod with SSL
REM mongo --ssl --sslCAFile ca.crt --sslPEMKeyFile client.pem --host `hostname -f`