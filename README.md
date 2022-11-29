#42HN_inception

The goal of this project is to familiarize the student with docker and it's main functonalities.
The student will virtualize several docker images inside a Debian based Virtual Machine, and connect them.  
This project in general showcases the creation of a simple LEMP stack.


## Description
 * set up 3 docker containers:
	* one container that contains NGINX with TLSv1.2 or TLSv1.3
	* one that contains WordPress + php-fpm
	* one that contains MariaDB  
 * set up one volume, that contains the WordPress database and one volume that contains the WordPress website files  
 * use docker-compose and set all three containers up in the same docker-network      
 * contaners need to restart in case of a crash  

In typical 42 manner, this project is not about pulling ready-made images from dockerhub, but only using images for the underlying OS (Alpine or Debian), and configuring everything else via the containers Dockerfiles.  


## Learnings

 - FILL IN -

### Resources

* [https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-ubuntu-18-04](LEMP stack explanation)
* 


