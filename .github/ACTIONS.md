# GitHub Actions for this repo

What I added:
- `.github/workflows/ci.yml` — Node.js CI: install, lint, build, test.
- `.github/workflows/docker-publish.yml` — Build & push Docker image to GitHub Container Registry on pushes to `main`.

Quick notes & customization
- Package manager:
  - The CI uses `npm ci` by default. If you use `yarn` or `pnpm` replace `npm ci` with `yarn install --frozen-lockfile` or `pnpm install --frozen-lockfile`.
- Scripts:
  - Ensure package.json contains appropriate scripts: `lint`, `build`, `test`. The workflow uses `--if-present` so missing scripts won't break the whole run but you should add them for full checks.
- Coverage/artifacts:
  - The CI uploads `coverage` as an artifact if present. Update the `path` if you store coverage elsewhere.
- Docker publishing:
  - The Docker workflow pushes to GitHub Container Registry (ghcr.io). If you prefer Docker Hub, replace the `docker/login-action` step with Docker Hub login and set secrets DOCKER_USERNAME/DOCKER_PASSWORD in repository settings, and change the `tags` to `docker.io/<your-docker-username>/<repo>:tag`.
- Secrets & permissions:
  - For pushing to ghcr.io the default `GITHUB_TOKEN` is used. If you want finer control or GitHub Packages scope, set up a PAT with `write:packages` and store it in `secrets.PAT`.
- Test locally:
  - Before relying on CI, run `npm ci && npm run lint && npm run build && npm test` locally to confirm scripts behave as expected.

Next steps I recommend:
1. Tell me which package manager you use (npm, yarn, pnpm) so I can adapt the workflows exactly.
2. If you want Docker Hub instead of GHCR, tell me and I’ll provide the modified workflow and the exact secret names to set.
3. If you want additional workflows (e.g., Dependabot config, release on tag, PR label automation, CI caching improvements, test coverage reporting), tell me which and I’ll add them.

If you want, I can push these files to a branch and open a PR — tell me the branch name to use (or I can create `ci/workflows-setup`) and whether you want me to include changes for yarn/pnpm now.