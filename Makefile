env=local
build:
	docker compose -f docker-compose.${env}.yml build
up:
	docker compose -f docker-compose.${env}.yml up -d
down:
	docker compose -f docker-compose.${env}.yml down

restart:
	make down
	make up

exec:
	docker exec -it app sh