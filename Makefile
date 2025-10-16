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


# =====================================
# 📚 Documentation & Help
# =====================================

help: ## Show this help message
	@echo "Available commands:"
	@echo ""
	@python3 -c "import re; lines=open('Makefile', encoding='utf-8').readlines(); targets=[re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$',l) for l in lines]; [print(f'  make {m.group(1):<20} {m.group(2)}') for m in targets if m]"


# =======================
# 🎯 PHONY Targets
# =======================

# Auto-generate PHONY targets (cross-platform)
.PHONY: $(shell python3 -c "import re; print(' '.join(re.findall(r'^([a-zA-Z_-]+):\s*.*?##', open('Makefile', encoding='utf-8').read(), re.MULTILINE)))")

# Test the PHONY generation
# test-phony:
# 	@echo "$(shell python3 -c "import re; print(' '.join(sorted(set(re.findall(r'^([a-zA-Z0-9_-]+):', open('Makefile', encoding='utf-8').read(), re.MULTILINE)))))")"
