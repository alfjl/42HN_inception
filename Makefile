# 'Protect' the make rules in order to avoid a conflict with a file of the same name,
# and to improve performance.
.PHONY:
	all clean fclean re prune

# Build and run all containers for LEMP stack via docker-compose.yml
all:
	mkdir -p ~/data/wordpress_database
	mkdir -p ~/data/wordpress_files
	docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up

# Stop all containers for LEMP stack via docker-compose.yml
clean:
	docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env down

# Stop all containers for LEMP stack via docker-compose.yml down
# Remove named volumes declared in the `volumes` section of the Compose file and
# anonymous volumes attached to containers
# Remove all images belonging to the LEMP stack
# Delete all files in the database and wordpress files volumes on the host VM
fclean:
	docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env down --volumes --rmi all
	sudo rm -rf /home/alf/data/wordpress_database
	sudo rm -rf /home/alf/data/wordpress_files

# Clean up and rerun docker-compose
re: fclean all

# ==========| BE AWARE: For debugging purposes only! |========== #
# removes all unused containers, networks and images on the system (not just dangling ones)
# Dosen't prompt for confirmation
prune:
	docker system prune -a -f