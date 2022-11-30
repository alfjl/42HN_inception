# Dockerfile

# get penultimate stable version of Debian
FROM debian:buster

# initially update and upgrade the system \ install ngix \ install openssl ('-y' answers yes to all prompts)
RUN apt-get -y update & apt-get -y upgrade \
    apt-get install -y nginx \
    apt-get install -y openssl

# copy custom nginx config file from the VM into the container 
COPY ./conf/inception_nginx.conf /etc/nginx/sites-available/inception_nginx.conf

# (https://www.linode.com/docs/guides/create-a-self-signed-tls-certificate/)
# Create a 4096 bit RSA key for use with the certificate
RUN openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out MyCertificate.crt -keyout MyKey.key

# expose port 443, as the only bridge between the www and the webserver
# EXPOSE 443
# not needed! We set port 443 in the config file

# runs nginx with debug symbols in the foreground
#
# '-g': nginx is compiled with -g by default. Good practice?
#
# 'daemon-off': runs nginx in the foreground as the one process running on the OS.
# (https://itecnote.com/tecnote/docker-the-difference-between-nginx-daemon-on-off-option/) 
# Otherwise docker can't track the nginx process and stops the container. 
# (https://hub.docker.com/_/nginx/)
CMD ["nginx", "-g", "daemon-off;"]
