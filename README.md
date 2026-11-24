# flate CI image

A small GitLab CI image containing the official flate binary, Alpine's shell
and grep, and CA certificates. The upstream flate image is distroless; this
wrapper adds the tools GitLab Runner needs without installing flate in each job.

GitHub Actions builds and smoke-tests Linux amd64 on pull requests. Successful
main-branch builds publish `ghcr.io/whaleyarn/flate:latest` and a full commit-SHA
tag. No personal token is needed by the workflow; it uses GitHub's job token.
Set the GHCR package visibility to public after its first publication if needed.

Pin consumers to the published image digest. A GitLab job then needs only:

```yaml
validate:flux:
  image: ghcr.io/whaleyarn/flate@sha256:<published-digest>
  script:
    - flate test --path app/base --kube-version 1.35.0
```

The image validates rendering, not live upgrades or Kubernetes API schemas.
Charts and referenced sources still require network access. Choose non-secret
inputs; do not point the agent's local checks at production secrets.

## Maintenance

Update the two image versions in `Dockerfile` through a pull request. Keep the
wrapper small; additional validation belongs in the consuming repository.
Use local Git for edits and `gh pr` / `gh run` to manage reviews and builds.

```sh
docker build -t flate:test .
docker run --rm flate:test flate --version
```
