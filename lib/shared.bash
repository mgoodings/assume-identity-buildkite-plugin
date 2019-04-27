#!/bin/bash

# Shorthand for reading env config
function plugin_read_config() {
  local var="BUILDKITE_PLUGIN_ASSUME_IDENTITY_${1}"
  local default="${2:-}"
  echo "${!var:-$default}"
}

# Generates a block step pipeline
generate_pipeline() {
  local label="$1"

  cat <<YAML
steps:
  - block: "${label}"

YAML
}

# Finds a block job id in the current build using a label
find_blocked_job_id_with_label() {
  local token="$1"
  local label="$2"

  curl -sf \
    -H "Authorization: Bearer ${token}" \
    -X GET "https://api.buildkite.com/v2/organizations/${BUILDKITE_ORGANIZATION_SLUG}/pipelines/${BUILDKITE_PIPELINE_SLUG}/builds/${BUILDKITE_BUILD_NUMBER}" | \
    jq -r --arg LABEL "${label}" \
      '.jobs[] | select(.type == "manual" and .unblockable == true and .label == $LABEL) | .id'
}

# Unblocks a job for the current pipeline using the job id
unblock_job_by_id() {
  local token="$1"
  local job_id="$2"

  curl -sf \
    -H "Authorization: Bearer ${token}" \
    -X PUT "https://api.buildkite.com/v2/organizations/${BUILDKITE_ORGANIZATION_SLUG}/pipelines/${BUILDKITE_PIPELINE_SLUG}/builds/${BUILDKITE_BUILD_NUMBER}/jobs/{$job_id}/unblock" \
    -d '{}'
}
