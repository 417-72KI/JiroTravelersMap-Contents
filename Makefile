build:
	@docker build -t dev .

run: build
	@docker run -v `pwd`:/work -w /work -i dev

deploy: run
	@firebase deploy
