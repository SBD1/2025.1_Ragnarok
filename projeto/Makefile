DOCKER_COMPOSE_FILE := docker-compose.yml

DOCKER_COMPOSE_COMMAND := docker compose

DB_SERVICE_NAME := db

DB_VOLUME_NAME := db_data

DB_USER := igris
DB_NAME := ragnarok

.PHONY: all up down restart logs build rebuild-up ps clean-volumes shell-db psql-db run-app help

all: help ## Exibe esta mensagem de ajuda.

detached: ## Sobe os containers em segundo plano (detached).
	@echo "Subindo os container Docker..."
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) up -d

up: ## Sobe os containers.
	@echo "Subindo os containers Docker..."
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) up

down: ## Derruba os containers.
	@echo "Derrubando os containers Docker..."
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) down

restart: ## Reinicia os serviços (sem reconstruir imagens).
	@echo "Reiniciando os serviços Docker..."
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) restart

logs: ## Exibe os logs dos containers (Ctrl+C para sair).
	@echo "Exibindo os logs dos containers Docker..."
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) logs -f

build: ## Reconstroi as imagens Docker (útil se você modificar Dockerfiles).
	@echo "Reconstruindo as imagens Docker..."
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) build

rebuild-up: ## Reconstroi imagens e sobe os containers.
	@echo "Reconstruindo imagens e subindo os containers Docker..."
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) up -d --build

ps: ## Lista os containers em execução.
	@echo "Listando containers Docker Compose..."
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) ps

clean-volumes: ## ATENÇÃO: Derruba containers e apaga todos os dados persistentes (volumes).
	@echo "ATENÇÃO: Apagando todos os dados persistentes (volumes Docker)..."
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) down -v

shell-db: ## Abre um shell interativo no container do banco de dados.
	@echo "Abrindo um shell interativo no container do banco de dados ($(DB_SERVICE_NAME))..."
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) exec $(DB_SERVICE_NAME) bash || $(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) exec $(DB_SERVICE_NAME) sh

psql-db: ## Conecta ao psql dentro do container do banco de dados.
	@echo "Conectando ao psql dentro do container do banco de dados ($(DB_SERVICE_NAME))..."
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) exec $(DB_SERVICE_NAME) psql -U $(DB_USER) -d $(DB_NAME)

run-app: ## Executa o script Python do seu jogo.
	@echo "Executando o script Python do jogo..."
	python3 app/app.py

help: ## Exibe esta mensagem de ajuda.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
