#!/usr/bin/env bats
PATH="./tools:$PATH"

bats_require_minimum_version 1.5.0

@test "vlux passes without input files" {
  run -0 vlux test/empty
}

@test "vlux passes" {
  run -0 vlux test/valid -ignore-filename-pattern="kustomizeconfig.yaml"
}

@test "vlux fails without ignoring kustomizeconfig.yaml" {
  run -123 vlux test/valid
}

@test "vlux fails with yamllint" {
  run -1 vlux test/invalid/yamllint
}

@test "vlux fails with kubeconform on input files" {
  run -123 vlux test/invalid/input
}

@test "vlux fails when kustomize fails" {
  run -1 vlux test/invalid/kustomize
}

@test "vlux fails with kubeconform on built kustomization" {
  run -1 vlux test/invalid/kustomization
}
