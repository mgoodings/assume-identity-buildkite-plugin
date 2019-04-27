# Assume Identity Buildkite Plugin

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) for changing an existing builds assigned user.

## Why?

Is this your life?

![Buildkite Problem](https://i.imgur.com/A0WlLSr.png)

Currently Buildkite will not let you create a trigger step in your pipeline if the current build was created from a user not in your organization.

This can happen when your build is created from a webhook and the email in the git commit does not match a user's email in your organization.

## How?

When creating a trigger step, Buildkite will use the identity of the current builds owner unless another user has interacted with a block step. If a user has interacted with a block step they will become the owner of any triggered pipelines later in the build.

This plugin (ab)uses this functionality to upload a new block step into the current build and then immediately calls the Buildkite API to unblock this step as the user you wish to assume.

![Buildkite Solution](https://i.imgur.com/bPOeovq.png)

## Example

```yml
steps:
  - plugins:
    - mgoodings/assume-identity#v1.0.0:
        token: <users-api-token>

  - wait
```

## Configuration

### `token`

The API token for the user you wish to assign this build to.

### `label` (optional)

The label of the block step. Defaults to ":cop: Halt! Identify!".

## Developing

To run the tests:

```bash
docker-compose run --rm tests
```
