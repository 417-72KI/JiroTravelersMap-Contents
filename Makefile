.SILENT:

container:
	docker compose build build validate

build: container
	docker compose run --rm build

validate: build
	docker compose run --rm validate

local: build validate
	firebase serve --only hosting

deploy: build validate
	firebase deploy
