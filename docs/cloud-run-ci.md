# Cloud Run CI/CD

This repo deploys the FastAPI site to Google Cloud Run from GitHub Actions.

## Cost posture

- GitHub Actions builds the Docker image, so routine deploys do not use Cloud Build minutes.
- Cloud Run is deployed with `--min-instances=0`, request-time CPU throttling, startup CPU boost disabled, and a max of 1 instance.
- Artifact Registry uses a single mutable `latest` image tag plus immutable digest deploys and a cleanup policy that deletes old images after 14 days while keeping the last 3 versions.
- The app has no database, queue, bucket mount, VPC connector, load balancer, or paid always-on service in this setup.

## Existing Google Cloud inventory

As of setup, project `tony-destro-website-231405` had billing enabled, Artifact Registry enabled, and no Cloud Run API/service yet. It also had one old Cloud Build trigger from 2019:

```text
34d4a70f-4dc1-4353-a601-38fa66ca38a6
```

That trigger watches `master` through the Cloud Source mirror `github_tdestro_tonydestro_2Ecom` and only builds an image to old `gcr.io`; it does not deploy Cloud Run. The setup script deletes that old trigger and mirror by default so GitHub Actions is the only deploy path.

## One-time setup

Run from the repository root with a Google account that owns or administers `tony-destro-website-231405`:

```bash
bash scripts/setup_cloud_run_ci.sh
```

The script creates:

- Artifact Registry Docker repo: `website`
- Cloud Run deploy service account: `github-cloud-run-deployer@tony-destro-website-231405.iam.gserviceaccount.com`
- Cloud Run runtime service account: `tony-destro-website-runner@tony-destro-website-231405.iam.gserviceaccount.com`
- Workload Identity Federation pool/provider for `tdestro/tonydestro.com`
- GitHub Actions repo variables used by `.github/workflows/deploy-cloud-run.yml`

## Deploy behavior

Pushing to `master` deploys changed app/container files to:

```text
Cloud Run service: tony-destro-website
Project: tony-destro-website-231405
Region: us-east1
```

You can also run the workflow manually from GitHub Actions on `master`. The Workload Identity provider is restricted to `tdestro/tonydestro.com` on `refs/heads/master`.
