# Dockerfile
# (https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run)

# get penultimate stable version of Debian
FROM debian:buster

# initially update the system to prevent old dependencies (cache bust)
# install curl
# install mariadb-client
# install php
# ('-y' answers yes to all prompts)
# delete the apt cache, to prevent potential parsing errors
# (https://websetnet.net/fixing-unable-to-parse-package-file-var-lib-apt-lists-error-in-ubuntu-and-other-linux-distributions/)
RUN apt-get update -y && \
    apt-get install -y curl && \
    apt-get install -y 

# copy custom wordpress config file from the host VM into the container 
COPY src dockerfile_best

# expose port 9000 to other docker containers on the same system (in the case of our project: nginx)
# EXPOSE 9000
# needed? We set port 9000 in the config file

#
CMD []