# Dockerfile
# (https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run)

# get penultimate stable version of Debian
FROM debian:buster

# initially update the system to prevent old dependencies (cache bust)
# install ngix
# install openssl
# ('-y' answers yes to all prompts)
# delete the apt cache, to prevent potential parsing errors
# (https://websetnet.net/fixing-unable-to-parse-package-file-var-lib-apt-lists-error-in-ubuntu-and-other-linux-distributions/)
RUN apt-get update -y && \
    apt-get install -y nginx && \
    apt-get install -y openssl && \
    rm -r /var/lib/apt/lists/*

# copy custom nginx config file from the host VM into the container 
COPY conf/nginx.conf /etc/nginx/sites-available/default

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
    -out /etc/ssl/certs/nginx.crt \
    -keyout /etc/ssl/private/nginx.key \
    -subj "/CN=alanghan.42.fr"

# expose port 443, as the only bridge between the www and the webserver
# EXPOSE 443
# needed? We set port 443 in the config file

# runs nginx with debug symbols in the foreground
# -g: nginx is compiled with -g by default. Still good practice to use here?
# daemon-off: runs nginx in the foreground as the one process running on the OS,
# otherwise docker can't track the nginx process and stops the container. 
# (https://itecnote.com/tecnote/docker-the-difference-between-nginx-daemon-on-off-option/) 
# (https://hub.docker.com/_/nginx/)
CMD ["nginx", "-g", "daemon off;"]
