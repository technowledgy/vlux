#!/usr/bin/env bats
PATH="./tools:$PATH"

@test "vlux passes without input files" {
  run -0 vlux test/empty
}

@test "vlux passes" {
  run -0 vlux test/valid
}

@test "vlux fails with yamllint" {
  run -1 vlux test/invalid/yamllint
}

@test "vlux fails with kubeval on input files" {
  run -123 vlux test/invalid/input
}

@test "vlux fails when kustomize fails" {
  run -1 vlux test/invalid/kustomize
}

@test "vlux fails with kubeval on built kustomization" {
  run -123 vlux test/invalid/kustomization
}
