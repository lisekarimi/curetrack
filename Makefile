include .env
export

up:
	docker compose up

down:
	docker compose down

logs:
	docker compose logs -f

restart:
	docker compose down
	docker compose up

pull:
	docker compose pull

ps:
	docker compose ps

db:
	docker exec -it curetrack-db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB)

cleanup:
	find ./backups -name "backup_*.sql" -mtime +15 -delete

backup:
	mkdir -p ./backups
	docker exec curetrack-db pg_dump -U $(POSTGRES_USER) -d $(POSTGRES_DB) > ./backups/backup_$(shell date +%Y%m%d_%H%M%S).sql
	$(MAKE) cleanup

.PHONY: up down logs restart pull ps backup cleanup
