RUNTIME:=$(shell which podman || which docker)
IMAGE:=hammer:latest

all: container

container:
	$(RUNTIME) build -t $(IMAGE) .

run:
	$(RUNTIME) run -ti --rm $(IMAGE)
