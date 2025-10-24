# WIP: Github Actions Container Images

## Goals
- [ ] Prepare images with installed dependencies to speedup CI
- [ ] Provide an environment similar to the default context `ubuntu-latest` (allowing using `docker compose`)

### Implemented
- [ ] Base: [Ubuntu 24.04](https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2404-Readme.md) with [DinD](https://www.docker.com/resources/docker-in-docker-containerized-ci-workflows-dockercon-2023/) support
- [ ] Playwright: Base image with Node, Pnpm and Playwright

### Todo
- Check [the issues](https://github.com/jclaveau/github-action-container-images/issues)

## License

MIT