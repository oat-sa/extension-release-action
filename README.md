# Tao release docker action

This action used to automatically release tao extension

## Inputs

### `github_token`

## Outputs

### `release_result`
release result message: success|skip|failure

## Example usage
```
name: Relese Tao extension
on:
  pull_request:
    branches:
      - develop
    types: [closed]
jobs:
  auto-release:
    if: github.event.pull_request.merged == true
    name: Automated Tao extension release
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Release
        uses: oat-sa/extension-release-action@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GH_TOKEN }}
        with:
          github_token: ${{ secrets.GH_TOKEN }}
```

## Publishing

Actions are released as tags:
- one tag that reflects the exact version
- a major version tag that points to the last tag of that version

For example, when releasing the version `v1.2.3`, ensure the tag `v1` points to that version as well.
Check the code example bellow:

```shell
git fetch
git checkout main
git pull
git tag -d v1
git tag v1
git push origin :v1
git push origin v1
```

## Releasing tao-release Docker image

1) Login as a user that has access and execute:

```shell
cd docker
docker build -f Dockerfile-tao-release . -t taotesting/tao-release:1.0
docker tag taotesting/tao-release:1.0 taotesting/tao-release:1.0
docker push taotesting/tao-release:1.0
```

2) Check if the image is there

Access [docker hub](https://hub.docker.com/repository/docker/taotesting/tao-release).