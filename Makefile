IMAGE = fmind/lab

build:
	docker build -t ${IMAGE} .

push: build
	docker push ${IMAGE}

run:
	docker run -it ${IMAGE}
