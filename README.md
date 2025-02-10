# Schematic Buildpacks

Based on Cloud Native Buildpacks, Schematic Buildpacks transform your application source code into container images that can run on any cloud without using Dockerfiles.

# Laungage Buildpacks

Schematic Buildpacks support the following language builds:

  * Python
    * __uv__, Python packaging in Rust, is used to manage:
      * Python version
      * Python package dependencies

There will be more language build support coming soon.

# Introduction

## Prerequisites

  * kpack is installed and available on a Kubernetes cluster
    ```
    make install.kpack
    ```
  * kpack CLI is installed and available on the client machine
    ```
    make install.kp_cli
    ```

## Setup kpack

Run the following command to setup the following kpack resources:

  * Image registry credentials
  * Kpack service account
  * Kpack cluster store
  * Kpack cluster stack
  * Kpack builder

```
make setup.kpack
```

## Build base images for buildpacks

Schematic Buildpacks come with its own build base image and run base image which are built based on Amazon Linux 2023 (minimal).

To build and publish build base image:

```
make build.base.build_base
make push.base.build_base
```

To build and publish run base image:

```
make build.base.run_base
make push.base.run_base
```
