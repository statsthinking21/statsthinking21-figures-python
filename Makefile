DOCKER_USERNAME = poldrack

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
	docker push $(DOCKER_USERNAME)/statsthinking21-nb

docker-build: guard-DOCKER_USERNAME
	sudo docker build -t $(DOCKER_USERNAME)/statsthinking21-nb .

# add -p 8888:8888 for jupyter
shell: guard-DOCKER_USERNAME
	sudo docker run -it --entrypoint=bash -v $(current_dir):/analysis $(DOCKER_USERNAME)/statsthinking21-nb 

