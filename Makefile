ifeq ($(OS),Windows_NT)
	SHELL := pwsh.exe
else
	SHELL := pwsh
endif

.SHELLFLAGS := -NoProfile -Command

REGISTRY_NAME := forgejo.themongoose.xyz/
REPOSITORY_NAME := brandon/
IMAGE_NAME := qr_generator
TAG := :latest

.PHONY: all test clean
all: docker_run

venv_create:
	python -m venv ".venv"

venv_activate:
	. ".\.venv\bin\activate"

venv_deactivate:
	. ".\.venv\bin\deactivate"

install_reqs: 
	pip install -r 'requirements.txt'
test:
	echo 'Not Implemented'
clean:
	echo 'Not Implemented'
run:
	python main.py

getcommitid: 
	$(eval COMMITID = $(shell git log -1 --pretty=format:"%H"))
getbranchname:
	$(eval BRANCH_NAME = $(shell (git branch --show-current ) -replace '/','.'))
build: docker_build
docker_build: getcommitid getbranchname
	docker build -t $(REGISTRY_NAME)$(REPOSITORY_NAME)$(IMAGE_NAME):latest -t $(REGISTRY_NAME)$(REPOSITORY_NAME)$(IMAGE_NAME):$(BRANCH_NAME) -t $(REGISTRY_NAME)$(REPOSITORY_NAME)$(IMAGE_NAME):$(BRANCH_NAME).$(COMMITID) .

docker_run: docker_build
	docker run -it -p 3008:3008 $(REGISTRY_NAME)$(REPOSITORY_NAME)$(IMAGE_NAME)$(TAG)