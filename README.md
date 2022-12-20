# 42HN_inception

The goal of this project is to familiarize the student with docker and it's main functonalities.
The student will virtualize several docker images inside a Debian based Virtual Machine, and connect them.  
This project in general showcases the creation of a simple LEMP stack.


## Description
 * set up 3 docker containers:
	* one container that contains NGINX with TLSv1.2 or TLSv1.3 protocol  
	* one that contains WordPress + php-fpm
	* one that contains MariaDB  
 * set up one volume, that contains the WordPress database and one volume that contains the WordPress website files  
 * use docker-compose and set all three containers up in the same docker-network      
 * contaners need to restart in case of a crash  

In typical 42 manner, this project is not about pulling ready-made images from dockerhub, but only using images for the underlying OS (Alpine or Debian), and configuring everything else via the containers Dockerfiles.  


## Learnings

A nice introduction into the idea of the LEMP stack. I wrote a nginx-like webserver in C++ from scratch before, but that was the first time I saw how to use such a server in a practical manner, apart from hosting my own static website.  
Further, this project made me explore how the syntax and structure of Dockerfiles and docker-compose files work, and gave me a general idea on how to define and run my own multi-container Docker applications.  

### Resources

* [LEMP stack explanation](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-ubuntu-18-04)
* [Dockerfile best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run)
* [docker-compose file documentation](https://docs.docker.com/compose/compose-file/)
* [MariaDB documentation](https://mariadb.com/kb/en/documentation/)
* [WP-CLI commands](https://developer.wordpress.org/cli/commands/)
* [nginx documentation](http://nginx.org/en/docs/)
