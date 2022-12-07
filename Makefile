# 'Protect' the make rules in order to avoid a conflict with a file of the same name,
# and to improve performance.
.PHONY:
    all clean fclean re

# Build and run all containers for LEMP stack via docker-compose.yml
all:
    docker-compose -f ./srcs/docker-compose.yml up

# Stop all containers for LEMP stack via docker-compose.yml
clean:
    docker-compose -f ./srcs/docker-compose.yml down

# Stop all containers for LEMP stack via docker-compose.yml
# Remove named volumes declared in the `volumes` section of the Compose file and
# anonymous volumes attached to containers
# Remove all images belonging to the LEMP stack
# Delete all files in the database and wordpress files volumes on the host VM
fclean:
    docker-compose -f ./srcs/docker-compose.yml down --volumes --rmi all
	rm -rf /home/alf/data/wordpress_database/*
	rm -rf /home/alf/data/wordpress_files/*

# Clean up and rerun docker-compose
re: flcean all
