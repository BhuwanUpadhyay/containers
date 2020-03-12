deploy:
	docker-compose build --no-cache && docker-compose up
scale:
	docker-compose scale pg_replica=3
clean:
	docker-compose down