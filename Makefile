run: 
	@docker-compose run --rm build

deploy: run
	@firebase deploy
