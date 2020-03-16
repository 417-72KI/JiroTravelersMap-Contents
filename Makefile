build:
	@docker-compose build

run: build
	@docker-compose run --rm build

validate: build
	@docker-compose run --rm validate

deploy: run validate
	@firebase deploy
