# Build base image operations

build:
	@${CONTAINER_CLI} build . \
		-f Dockerfile.${base} \
		-t ${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${tag} \
		--target release \
		--platform ${PLATFORM} && \
		base_tag=$$(${CONTAINER_CLI} inspect -f '{{ .Created }}' \
			${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${tag} | \
			cut -d '.' -f 1 | \
			tr -d ":-"|tr T .) && \
		${CONTAINER_CLI} tag \
			${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${tag} \
			${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${tag}-$${base_tag}

shell:
	@${CONTAINER_CLI} run -it --rm \
		--name ${PROJECT}_${base} \
		${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${tag} \
		/bin/bash || true

push:
	@base_tag=$$(${CONTAINER_CLI} inspect -f '{{ .Created }}' \
			${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${tag} | \
			cut -d '.' -f 1 | \
			tr -d ":-"|tr T .) && \
		${CONTAINER_CLI} push ${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${tag}-$${base_tag} && \
		${CONTAINER_CLI} push ${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${tag}

image:
	@${CONTAINER_CLI} images | grep ${IMAGE_REPO_ROOT}/${PROJECT}_${base} | grep ${tag} || \
		echo "Error! Base image for ${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${tag}, is NOT found."
