# Assume Identity Buildkite Plugin

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) for changing an existing builds assigned user.

## Example

```yml
steps:
  - plugins:
    - mgoodings/assume-identity#v1.0.0:
        token: <users-api-token>
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
