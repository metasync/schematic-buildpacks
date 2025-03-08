## [0.1.3] (2025-03-04)

  * Added an ArgoCD Custom Health Check for kpack.io/Image
  * Added an ArgoCD notification (Trigger & Template) for kpack.io/Image in order to restart deployment after the image is built
  * Added kpack namespace
  * Added bootstrap for kpack in Makefile
  * Refactored kpack setup accordingly

## [0.1.2] (2025-02-24)

  * Refactored buildpack
  * Added non-shell launch
  * Added stack ID as image lable
  * Refactored kpack script
  * Code cleanup

## [0.1.1] (2025-02-11)

  * Added kpack setup script
  * Added image CRD for:
    * Schematic Dagster - Dagster K8S (webserver & daemon)
    * Dagster Hello World - a sample Dagster project

## [0.1.0] (2025-02-10)

  * First release for Schematic Buildpacks
    * Python buildpack with uv
    * Build/run base images based on Amazon Linux 2023 (minimal)
    * kpack support
