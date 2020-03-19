crawl:
	@docker-compose build crawl
	@docker-compose run --rm crawl

container:
	@docker-compose build build validate

build: container
	@docker-compose run --rm build

validate: build
	@docker-compose run --rm validate

deploy: build validate
	@firebase deploy
