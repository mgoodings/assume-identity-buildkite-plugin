#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

# Uncomment to enable stub debug output:
# export BUILDKITE_AGENT_STUB_DEBUG=/dev/tty

@test "Command without a token" {
  run "$PWD/hooks/command"

  assert_failure
  assert_output --partial "Could not find an api token"
}
