IMAGE_NAME := dictanova/docker-debian-kitchen

debian-8:
	docker pull debian:jessie-backports
	docker build -t ${IMAGE_NAME}:$@ $@

debian-8-java:
	docker pull debian:jessie-backports
	docker build -t ${IMAGE_NAME}:$@ $@

debian-9:
	docker pull debian:stretch
	docker build -t ${IMAGE_NAME}:$@ $@

debian-9-java:
	docker pull debian:stretch
	docker build -t ${IMAGE_NAME}:$@ $@

all: debian-8 debian-8-java debian-9 debian-9-java
.PHONY: debian-8 debian-8-java debian-9 debian-8-java
