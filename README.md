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

-   one tag that reflects the exact version
-   a major version tag that points to the last tag of that version

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

1. Login as a user that has access and execute:

```shell
cd docker
docker build -f Dockerfile-tao-release . -t taotesting/tao-release:1.0

docker tag taotesting/tao-release:1.0 taotesting/tao-release:1.0
docker push taotesting/tao-release:1.0

docker tag taotesting/tao-release:1.0 taotesting/tao-release:latest
docker push taotesting/tao-release:latest
```

2. Check if the image is there

Access [docker hub](https://hub.docker.com/repository/docker/taotesting/tao-release).

## Creating and publishing a multi arch image

For Apple Silicon owners, and other ARM powered machine, here is how to build an publish the images.

**Note:** the image build will come together with the publication. This is needed to push directly to a repository if you want Docker Desktop to automatically manage the manifest list for you.

First you need to prepare the engine:

-   enable the `Experimental Features` in Docker (from the config options in the desktop application)
-   start the engine: `docker buildx create --use`

Build and publish a multi arch image:

```
docker buildx build --platform linux/amd64,linux/arm64 --push -t taotesting/tao-release:1.1 -f Dockerfile-tao-release .
```

**Note:** you will need to use the proper tag as it would be better to use a different version, like `1.2`, `1.3`, etc.

Tag the new image as the latest:

```
docker buildx imagetools create -t taotesting/tao-release:latest taotesting/tao-release:1.1
```

Reference:

-   https://blog.jaimyn.dev/how-to-build-multi-architecture-docker-images-on-an-m1-mac/
-   https://stackoverflow.com/questions/74066597/how-to-tag-multi-architecture-docker-image-and-push-the-newly-tagged-image
