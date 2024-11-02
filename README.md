# vlux

![GitHub Workflow Status](https://img.shields.io/github/workflow/actions/status/technowledgy/vlux/push.yaml?branch=main)
![GitHub](https://img.shields.io/github/license/technowledgy/vlux)

This image **v**alidates f**lux** repos in CI.

## How to use

Run `vlux <directory>` in the container to search for .yaml files recursively. All files will be validated with `yamllint` and `kubeconform`. `kustomization.yaml` files will be built with `kustomize` and the result will be validated again with `kubeconform`.

Extra arguments to the script will be passed to `kubeconform`, e.g. `vlux <directory> -ignore-filename-pattern="kustomizeconfig.yaml"`