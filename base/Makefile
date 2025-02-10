# Build base image operations

build:
	@${CONTAINER_CLI} build . \
		-f Dockerfile.${base} \
		-t ${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${BASE_OS} \
		--target release \
		--platform ${PLATFORM} && \
		base_tag=$$(${CONTAINER_CLI} inspect -f '{{ .Created }}' \
			${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${BASE_OS} | \
			cut -d '.' -f 1 | \
			tr -d ":-"|tr T .) && \
		${CONTAINER_CLI} tag \
			${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${BASE_OS} \
			${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${BASE_OS}-$${base_tag}

shell:
	@${CONTAINER_CLI} run -it --rm \
		--name ${PROJECT}_${base} \
		${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${BASE_OS} \
		/bin/bash || true

push:
	@base_tag=$$(${CONTAINER_CLI} inspect -f '{{ .Created }}' \
			${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${BASE_OS} | \
			cut -d '.' -f 1 | \
			tr -d ":-"|tr T .) && \
		${CONTAINER_CLI} push ${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${BASE_OS}-$${base_tag} && \
		${CONTAINER_CLI} push ${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${BASE_OS}

image:
	@${CONTAINER_CLI} images | grep ${IMAGE_REPO_ROOT}/${PROJECT}_${base} | grep ${BASE_OS} || \
		echo "Error! Base image for ${IMAGE_REPO_ROOT}/${PROJECT}_${base}:${BASE_OS}, is NOT found."
