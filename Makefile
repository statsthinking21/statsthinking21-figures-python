DOCKER_USERNAME = poldrack
NB_NAME = datascience-notebook

build-python-book:
	-rm -rf src/_build
	jupyter-book build src


# code to check environment variables
# from https://stackoverflow.com/questions/4728810/makefile-variable-as-prerequisite

guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

# from https://stackoverflow.com/questions/18136918/how-to-get-current-relative-directory-of-your-makefile

current_dir = $(shell pwd)


# commands for building and testing docker image

docker-deploy: docker-login docker-upload

docker-login: guard-DOCKER_USERNAME guard-DOCKER_PASSWORD
	docker login --username=$(DOCKER_USERNAME) --password=$(DOCKER_PASSWORD)

docker-upload: guard-DOCKER_USERNAME
	docker push $(DOCKER_USERNAME)/${NB_NAME}

docker-build: guard-DOCKER_USERNAME
	sudo docker build -t $(DOCKER_USERNAME)/${NB_NAME} .

# add -p 8888:8888 for jupyter
shell: guard-DOCKER_USERNAME
	sudo docker run -it -p 8888:8888  -e GRANT_SUDO=yes --entrypoint=bash -v $(current_dir):/home/jovyan/work/nb:rw $(DOCKER_USERNAME)/${NB_NAME}

jupyter: 
	sudo docker-compose up