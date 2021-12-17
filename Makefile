all:
	grep -Fx '127.0.0.1 eluceon.42.fr' /etc/hosts \
		|| (echo '127.0.0.1 eluceon.42.fr' | sudo tee -a /etc/hosts)
	mkdir -p $$HOME/data/wordpress
	mkdir -p $$HOME/data/db
	docker-compose -f ./srcs/docker-compose.yml up

stop:
	docker stop $$(docker ps -aq)

clean:
	docker-compose -f srcs/docker-compose.yml down
	@sudo rm -rf $$HOME/data

fclean: clean
	docker system prune --volume -af

re:
	make fclean
	make run

.PHONY: all stop clean fclean re reload