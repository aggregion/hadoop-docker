build:
	docker build -t aggregion/hadoop .

push:
	docker push aggregion/hadoop

all:
	make build
	make push
