IMAGE = fmind/lab

rebuild:
	docker build --no-cache -t ${IMAGE} .

build:
	docker build -t ${IMAGE} .

run: build
	docker run -it ${IMAGE}

push: rebuild
	docker push ${IMAGE}
