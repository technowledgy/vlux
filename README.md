# vlux

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/technowledgy/vlux/Push%20to%20main)
![GitHub](https://img.shields.io/github/license/technowledgy/vlux)

This image **v**alidates f**lux** repos in CI.

## How to use

Run `vlux <directory>` in the container to search for .yaml files recursively. All files will be validated with `yamllint` and `kubeval`. `kustomization.yaml` files will be built with `kustomize` and the result will be validated again with `kubeval`.
