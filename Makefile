.SILENT:

crawl:
	# npm --prefix containers/crawl start ../../resources/crawled
	docker-compose build crawl
	docker-compose run --rm crawl

container:
	docker-compose build build validate

build: container
	docker-compose run --rm build

validate: build
	docker-compose run --rm validate

local: build validate
	firebase serve --only hosting 

deploy: build validate
	firebase deploy
