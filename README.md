# Tony Destro Portfolio

Modern portfolio rebuild for `tonydestro.com`.

The original site is preserved under `legacy/public-html` as source material. The deployable application is the FastAPI/Jinja app under `app/`.

## Local run

```bash
uv run uvicorn app.main:app --reload --port 8000
```

Then open:

```text
http://127.0.0.1:8000
```

## Docker

```bash
docker build -t tonydestro-portfolio .
docker run --rm -p 8080:8080 tonydestro-portfolio
```

## Deployment target

The app is intended for Google Cloud Run. It serves dynamic-capable Python routes with file-backed JSON content and no database.

CI/CD is configured through GitHub Actions with Workload Identity Federation into Google Cloud Run. See `docs/cloud-run-ci.md` for the one-time setup and cost controls.

## Implementation policy

`tonydestro.com` has one authoritative implementation path for each feature. Do not add fallback screenshots, alternate static replicas, duplicate controls, or silent degraded experiences to mask a broken primary implementation. If something breaks, fix the implementation that is supposed to power the site.

Normal platform-level compatibility, such as CSS font stacks, semantic alt text, and responsive layout rules, is fine. Alternate user-facing versions of the same feature are not.

## Legacy policy

Do not deploy the full legacy folder by default. It contains historical PHP, ASP.NET, Flash, Subversion metadata, certificates, and large binary artifacts. Promote only reviewed images or safe static demos into `app/static`.
