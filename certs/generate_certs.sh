##
## Certificados de ejemplo para configuraciones particulares del demo.
##

# Create a root certificate and private key to sign the certificates for your services
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 \
    -subj '/O=example Inc./CN=example.com' \
    -keyout ./example.com.key \
    -out ./example.com.crt

# Generate a certificate and a private key for app1.example.com:
openssl req \
    -out ./app1.example.com.csr -newkey rsa:2048 -nodes \
    -keyout ./app1.example.com.key \
    -subj "/CN=app1.example.com/O=example organization"

openssl x509 -req -sha256 -days 365 \
    -CA ./example.com.crt \
    -CAkey ./example.com.key -set_serial 0 \
    -in ./app1.example.com.csr \
    -out ./app1.example.com.crt

# Create a second set of of certificates and keys for app2.example.com
openssl req \
    -out ./app2.example.com.csr -newkey rsa:2048 -nodes \
    -keyout ./app2.example.com.key \
    -subj "/CN=app2.example.com/O=example organization"

openssl x509 -req -sha256 -days 365 \
    -CA ./example.com.crt \
    -CAkey ./example.com.key -set_serial 0 \
    -in ./app2.example.com.csr \
    -out ./app2.example.com.crt

# Create secret for the ingress gateway 
kubectl create -n istio-system secret tls app1-credential \
  --key=./app1.example.com.key \
  --cert=./app1.example.com.crt

kubectl create -n istio-system secret tls app2-credential \
  --key=./app2.example.com.key \
  --cert=./app2.example.com.crt
