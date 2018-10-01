TAG ?= 0.0.1.dev
PREFIX ?= ${USER}/kafka-monitor

localcontainer:
	docker build -t $(PREFIX):$(TAG) .

clean:
	docker rmi $(PREFIX):$(TAG)

run:
	docker run -it --rm $(PREFIX):$(TAG)

runbash:
	docker run -it --rm --entrypoint bash $(PREFIX):$(TAG)
