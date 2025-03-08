include Makefile.env

export

# Base image operations

build.base.build_base:
	@$(MAKE) -C base build base=build_base tag=${BASE_OS}

shell.base.build_base:
	@$(MAKE) -C base shell base=build_base tag=${BASE_OS}

push.base.build_base:
	@$(MAKE) -C base push base=build_base tag=${BASE_OS}

image.base.build_base:
	@$(MAKE) -C base image base=build_base tag=${BASE_OS}

build.base.run_base:
	@$(MAKE) -C base build base=run_base tag=${BASE_OS}

shell.base.run_base:
	@$(MAKE) -C base shell base=run_base tag=${BASE_OS}

push.base.run_base:
	@$(MAKE) -C base push base=run_base tag=${BASE_OS}

image.base.run_base:
	@$(MAKE) -C base image base=run_base tag=${BASE_OS}

# Buildpack image operations

build.pack.base:
	@pack buildpack package \
		${IMAGE_REPO_ROOT}/schematic_buildpack_base:${BUILDPACK_BASE_VERSION} \
		--config ./packages/buildpack_base.toml \
		--target ${PLATFORM} \
		--publish
	
build.builder.base:
	@pack builder create \
		${IMAGE_REPO_ROOT}/schematic_builder_base:al2023 \
		--config ./builders/schematic_builder_base.toml \
		--target ${PLATFORM} \
		--publish

# Pack installation

install.pack_cli:
	@(pack version 2>&1 |grep -q ${PACK_VERSION} && \
		echo "Pack CLI ${PACK_VERSION} has been installed.") || \
		(echo "Installing Pack CLI (${HOST_OS}-${HOST_ARCH}) v${PACK_VERSION}..." && \
		curl -sSL "https://github.com/buildpacks/pack/releases/download/v${PACK_VERSION}/pack-v${PACK_VERSION}-macos-arm64.tgz" | sudo tar -C /usr/local/bin/ --no-same-owner -xzv pack)

install.pack_cli.linux:
	@(pack version 2>&1 |grep -q ${PACK_VERSION} && \
		echo "Pack CLI ${PACK_VERSION} has been installed.") || \
		(echo "Installing Pack CLI (${HOST_OS}-${HOST_ARCH}) v${PACK_VERSION}..." && \
		curl -sSL "https://github.com/buildpacks/pack/releases/download/v${PACK_VERSION}/pack-v${PACK_VERSION}-linux.tgz" | sudo tar -C /usr/local/bin/ --no-same-owner -xzv pack)

# Kpack operations

bootstrap.kpack: install.kpack install.kp_cli setup.kpack

install.kpack:
	@curl -sSL -o /tmp/kpack-release-${KPACK_VERSION}.yaml https://github.com/buildpacks-community/kpack/releases/download/v${KPACK_VERSION}/release-${KPACK_VERSION}.yaml && \
		kubectl apply -f /tmp/kpack-release-${KPACK_VERSION}.yaml && \
		kubectl wait --for=condition=Ready pods --all --namespace kpack && \
		rm /tmp/kpack-release-${KPACK_VERSION}.yaml

install.kp_cli:
	@(kp version 2>&1 |grep -q ${KP_CLI_VERSION} && \
		echo "kpack CLI ${KP_CLI_VERSION} has been installed.") || \
		(echo "Installing kpack CLI (${HOST_OS}-${HOST_ARCH}) v${KP_CLI_VERSION}..." && \
		curl -sSL -o /tmp/kp https://github.com/buildpacks-community/kpack-cli/releases/download/v${KP_CLI_VERSION}/kp-${HOST_OS}-${HOST_ARCH}-${KP_CLI_VERSION} && \
		chmod +x /tmp/kp && \
		sudo mv /tmp/kp /usr/local/bin/kp)

setup.kpack:
	@cd kpack && ./setup

# Misc operations

prune:
	@${CONTAINER_CLI} image prune -f
clean: prune
