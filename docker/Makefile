IMAGE_NAME := avojak/gitlab-fargate-driver-ubi8
VERSION := 1.0.0

.PHONY: image
image:
	docker build -t $(IMAGE_NAME):$(VERSION) -t $(IMAGE_NAME):latest .

.PHONY: push
push:
	docker push $(IMAGE_NAME):$(VERSION)
	docker push $(IMAGE_NAME):latest