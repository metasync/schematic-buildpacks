include Makefile.env

export

# Base image operations

build.base.build_base:
	@$(MAKE) -C base build base=build_base version=${BUILD_BASE_VERSION}

shell.base.build_base:
	@$(MAKE) -C base shell base=build_base version=${BUILD_BASE_VERSION}

push.base.build_base:
	@$(MAKE) -C base push base=build_base version=${BUILD_BASE_VERSION}

image.base.build_base:
	@$(MAKE) -C base image base=build_base version=${BUILD_BASE_VERSION}

build.base.run_base:
	@$(MAKE) -C base build base=run_base version=${RUN_BASE_VERSION}

shell.base.run_base:
	@$(MAKE) -C base shell base=run_base version=${RUN_BASE_VERSION}

push.base.run_base:
	@$(MAKE) -C base push base=run_base version=${RUN_BASE_VERSION}

image.base.run_base:
	@$(MAKE) -C base image base=run_base version=${RUN_BASE_VERSION}


# Kpack operations

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
