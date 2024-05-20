


REGISTRY_NAME := forgejo.themongoose.xyz/
REPOSITORY_NAME := brandon/
IMAGE_NAME := qr_generator
TAG := :latest

.PHONY: all test clean
all: docker_run

getcommitid: 
	$(eval COMMITID = $(shell git log -1 --pretty=format:"%H"))
getbranchname:
	$(eval BRANCH_NAME = $(shell echo "$$(git branch --show-current)" | sed 's/\//./g'))
get_file_safe_image_name:
	$(eval IMAGE_TAR_FILE_NAME = $(shell echo "$(IMAGE_NAME)" | sed 's/\//./g').tar)

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

build: docker_build
docker_build: getcommitid getbranchname
	docker build -t $(REGISTRY_NAME)$(REPOSITORY_NAME)$(IMAGE_NAME):latest -t $(REGISTRY_NAME)$(REPOSITORY_NAME)$(IMAGE_NAME):$(BRANCH_NAME) -t $(REGISTRY_NAME)$(REPOSITORY_NAME)$(IMAGE_NAME):$(BRANCH_NAME).$(COMMITID) .

docker_run: docker_build
	docker run -it -p 127.0.0.1:3008:3008 $(REGISTRY_NAME)$(REPOSITORY_NAME)$(IMAGE_NAME)$(TAG)

package: get_file_safe_image_name
	docker save $(REGISTRY_NAME)$(REPOSITORY_NAME)$(IMAGE_NAME)$(TAG) -o $(IMAGE_TAR_FILE_NAME)
size:
	docker inspect -f "{{ .Size }}" $(REGISTRY_NAME)$(REPOSITORY_NAME)$(IMAGE_NAME)$(TAG)
	docker history $(REGISTRY_NAME)$(REPOSITORY_NAME)$(IMAGE_NAME)$(TAG)

publish:
	docker login; docker push $(REGISTRY_NAME)$(REPOSITORY_NAME)$(IMAGE_NAME)$(TAG); docker logout