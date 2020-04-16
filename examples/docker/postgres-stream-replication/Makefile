.PHONY: help
.DEFAULT_GOAL := help
DEPLOYMENT_NAME := "postgres-stream-replication"

help:
	@echo "---------------------------------------------------------------------------------------"
	@echo ""
	@echo "				CLI"
	@echo ""
	@echo "---------------------------------------------------------------------------------------"
	@echo ""
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Development
build: ## Build the project
	docker-compose build --no-cache

##@ Release
publish: ## Publish the project
	docker-compose push

##@ Deployment
deploy: ## Deploy in docker swarm
	docker stack deploy --compose-file docker-compose.yml ${DEPLOYMENT_NAME}
list: ## List of services from docker swarm
	docker stack services ${DEPLOYMENT_NAME}
watch: ## Watch list of services from docker swarm
	watch "docker stack services ${DEPLOYMENT_NAME}"
logs: ## Logs of service from docker swarm
	@read -p "Service Name: " serviceName; \
	docker service logs -f ${DEPLOYMENT_NAME}_$$serviceName
inspect: ## Inspect of network from docker swarm
	@read -p "Network Name: " networkName; \
	docker network inspect ${DEPLOYMENT_NAME}_$$networkName
destroy: ## Destroy deployment in docker swarm
	docker stack rm ${DEPLOYMENT_NAME}
clean: ## Clean docker
	docker system prune && docker volume prune
ls: ## List all docker containers
	docker container ls -a