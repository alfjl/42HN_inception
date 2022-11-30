# Dockerfile

# get penultimate stable version of Debian
FROM debian:buster

# initially update and upgrade the system \ install ngix \ install openssl ('-y' answers yes to all prompts)
RUN apt-get -y update & apt-get -y upgrade \
    apt-get install -y nginx \
    apt-get install -y openssl

# copy custom nginx config file from the host VM into the container 
COPY ./conf/inception_nginx.conf /etc/nginx/sites-available/inception_nginx.conf

# (https://www.linode.com/docs/guides/create-a-self-signed-tls-certificate/)
# (https://www.openssl.org/docs/man1.0.2/man1/openssl-req.html)
# openssl req -newkey rsa:4096: Create a 4096 bit RSA key for use with the TLS certificate
# -x509: outputs a self signed certificate
# -days n: specifies the number of days to certify the certificate for
# -sha256: specifies the encryption algorithm for the certificate request
# -nodes: private key will not require a passphrase
# -out filename: specifies output filename to write to. Default = standard output
# -keyout filename: gives the filename to write newly created private key to
# -subj arg: sets subject name for requests. 'CN' = Common Name
RUN openssl req -newkey rsa:4096 \
    -x509 -days 365 \
    -sha256 -nodes \
    -out MyCertificate.crt \
    -keyout MyKey.key \
    -subj "/CN=alanghan.42.fr"

# expose port 443, as the only bridge between the www and the webserver
# EXPOSE 443
# not needed! We set port 443 in the config file

# runs nginx with debug symbols in the foreground
# -g: nginx is compiled with -g by default. Good practice?
# daemon-off: runs nginx in the foreground as the one process running on the OS
# Otherwise docker can't track the nginx process and stops the container. 
# (https://itecnote.com/tecnote/docker-the-difference-between-nginx-daemon-on-off-option/) 
# (https://hub.docker.com/_/nginx/)
CMD ["nginx", "-g", "daemon-off;"]
