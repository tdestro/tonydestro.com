#!/usr/bin/env bash
set -euo pipefail

PROJECT_ID="${PROJECT_ID:-tony-destro-website-231405}"
REGION="${REGION:-us-east1}"
SERVICE="${SERVICE:-tony-destro-website}"
ARTIFACT_REGISTRY_REPOSITORY="${ARTIFACT_REGISTRY_REPOSITORY:-website}"
DEPLOY_SERVICE_ACCOUNT_ID="${DEPLOY_SERVICE_ACCOUNT_ID:-github-cloud-run-deployer}"
RUNTIME_SERVICE_ACCOUNT_ID="${RUNTIME_SERVICE_ACCOUNT_ID:-tony-destro-website-runner}"
WORKLOAD_IDENTITY_POOL_ID="${WORKLOAD_IDENTITY_POOL_ID:-github-actions}"
WORKLOAD_IDENTITY_PROVIDER_ID="${WORKLOAD_IDENTITY_PROVIDER_ID:-tonydestro-com}"
GITHUB_REPOSITORY="${GITHUB_REPOSITORY:-tdestro/tonydestro.com}"
GITHUB_BRANCH="${GITHUB_BRANCH:-master}"
GH_SET_REPO_VARS="${GH_SET_REPO_VARS:-1}"
DELETE_LEGACY_GCP_DEPLOY="${DELETE_LEGACY_GCP_DEPLOY:-1}"
LEGACY_CLOUD_BUILD_TRIGGER_ID="${LEGACY_CLOUD_BUILD_TRIGGER_ID:-34d4a70f-4dc1-4353-a601-38fa66ca38a6}"
LEGACY_CLOUD_SOURCE_REPO="${LEGACY_CLOUD_SOURCE_REPO:-github_tdestro_tonydestro_2Ecom}"

cleanup_policy_file="deploy/artifact-registry-cleanup-policy.json"

if [[ "${PROJECT_ID}" != "tony-destro-website-231405" ]]; then
  echo "Refusing to run against PROJECT_ID=${PROJECT_ID}; this script is locked to tony-destro-website-231405." >&2
  exit 1
fi

if [[ ! -f "${cleanup_policy_file}" ]]; then
  echo "Missing ${cleanup_policy_file}; run this from the repo root." >&2
  exit 1
fi

project_number="$(gcloud projects describe "${PROJECT_ID}" --format="value(projectNumber)")"
deploy_service_account="${DEPLOY_SERVICE_ACCOUNT_ID}@${PROJECT_ID}.iam.gserviceaccount.com"
runtime_service_account="${RUNTIME_SERVICE_ACCOUNT_ID}@${PROJECT_ID}.iam.gserviceaccount.com"
workload_identity_provider="projects/${project_number}/locations/global/workloadIdentityPools/${WORKLOAD_IDENTITY_POOL_ID}/providers/${WORKLOAD_IDENTITY_PROVIDER_ID}"
workload_identity_principal="principalSet://iam.googleapis.com/projects/${project_number}/locations/global/workloadIdentityPools/${WORKLOAD_IDENTITY_POOL_ID}/attribute.repository/${GITHUB_REPOSITORY}"

echo "Enabling required Google Cloud APIs..."
gcloud services enable \
  artifactregistry.googleapis.com \
  cloudresourcemanager.googleapis.com \
  iam.googleapis.com \
  iamcredentials.googleapis.com \
  run.googleapis.com \
  sts.googleapis.com \
  --project="${PROJECT_ID}"

echo "Creating Artifact Registry repository if needed..."
if ! gcloud artifacts repositories describe "${ARTIFACT_REGISTRY_REPOSITORY}" \
  --project="${PROJECT_ID}" \
  --location="${REGION}" >/dev/null 2>&1; then
  gcloud artifacts repositories create "${ARTIFACT_REGISTRY_REPOSITORY}" \
    --project="${PROJECT_ID}" \
    --location="${REGION}" \
    --repository-format=docker \
    --description="Docker images for ${SERVICE}" \
    --disable-vulnerability-scanning
fi

echo "Applying Artifact Registry cleanup policy..."
gcloud artifacts repositories set-cleanup-policies "${ARTIFACT_REGISTRY_REPOSITORY}" \
  --project="${PROJECT_ID}" \
  --location="${REGION}" \
  --policy="${cleanup_policy_file}" \
  --quiet

echo "Creating deploy and runtime service accounts if needed..."
if ! gcloud iam service-accounts describe "${deploy_service_account}" \
  --project="${PROJECT_ID}" >/dev/null 2>&1; then
  gcloud iam service-accounts create "${DEPLOY_SERVICE_ACCOUNT_ID}" \
    --project="${PROJECT_ID}" \
    --display-name="GitHub Cloud Run deployer"
fi

if ! gcloud iam service-accounts describe "${runtime_service_account}" \
  --project="${PROJECT_ID}" >/dev/null 2>&1; then
  gcloud iam service-accounts create "${RUNTIME_SERVICE_ACCOUNT_ID}" \
    --project="${PROJECT_ID}" \
    --display-name="Tony Destro website runtime"
fi

echo "Granting least-practical deploy permissions..."
gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
  --member="serviceAccount:${deploy_service_account}" \
  --role="roles/run.admin" \
  --condition=None \
  --quiet

gcloud artifacts repositories add-iam-policy-binding "${ARTIFACT_REGISTRY_REPOSITORY}" \
  --project="${PROJECT_ID}" \
  --location="${REGION}" \
  --member="serviceAccount:${deploy_service_account}" \
  --role="roles/artifactregistry.writer" \
  --condition=None \
  --quiet

gcloud iam service-accounts add-iam-policy-binding "${runtime_service_account}" \
  --project="${PROJECT_ID}" \
  --member="serviceAccount:${deploy_service_account}" \
  --role="roles/iam.serviceAccountUser" \
  --condition=None \
  --quiet

echo "Creating Workload Identity Federation pool/provider if needed..."
if ! gcloud iam workload-identity-pools describe "${WORKLOAD_IDENTITY_POOL_ID}" \
  --project="${PROJECT_ID}" \
  --location=global >/dev/null 2>&1; then
  gcloud iam workload-identity-pools create "${WORKLOAD_IDENTITY_POOL_ID}" \
    --project="${PROJECT_ID}" \
    --location=global \
    --display-name="GitHub Actions"
fi

if ! gcloud iam workload-identity-pools providers describe "${WORKLOAD_IDENTITY_PROVIDER_ID}" \
  --project="${PROJECT_ID}" \
  --location=global \
  --workload-identity-pool="${WORKLOAD_IDENTITY_POOL_ID}" >/dev/null 2>&1; then
  gcloud iam workload-identity-pools providers create-oidc "${WORKLOAD_IDENTITY_PROVIDER_ID}" \
    --project="${PROJECT_ID}" \
    --location=global \
    --workload-identity-pool="${WORKLOAD_IDENTITY_POOL_ID}" \
    --display-name="tonydestro.com" \
    --issuer-uri="https://token.actions.githubusercontent.com" \
    --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository,attribute.ref=assertion.ref" \
    --attribute-condition="assertion.repository == '${GITHUB_REPOSITORY}' && assertion.ref == 'refs/heads/${GITHUB_BRANCH}'"
fi

echo "Allowing this GitHub repo to impersonate the deploy service account..."
gcloud iam service-accounts add-iam-policy-binding "${deploy_service_account}" \
  --project="${PROJECT_ID}" \
  --member="${workload_identity_principal}" \
  --role="roles/iam.workloadIdentityUser" \
  --condition=None \
  --quiet

if [[ "${GH_SET_REPO_VARS}" == "1" ]]; then
  if command -v gh >/dev/null 2>&1; then
    echo "Setting GitHub Actions repository variables..."
    gh variable set GCP_WORKLOAD_IDENTITY_PROVIDER \
      --repo="${GITHUB_REPOSITORY}" \
      --body="${workload_identity_provider}"
    gh variable set GCP_DEPLOY_SERVICE_ACCOUNT \
      --repo="${GITHUB_REPOSITORY}" \
      --body="${deploy_service_account}"
  else
    echo "gh was not found; set these repository variables manually:"
    echo "GCP_WORKLOAD_IDENTITY_PROVIDER=${workload_identity_provider}"
    echo "GCP_DEPLOY_SERVICE_ACCOUNT=${deploy_service_account}"
  fi
else
  echo "Set these GitHub Actions repository variables:"
  echo "GCP_WORKLOAD_IDENTITY_PROVIDER=${workload_identity_provider}"
  echo "GCP_DEPLOY_SERVICE_ACCOUNT=${deploy_service_account}"
fi

if [[ "${DELETE_LEGACY_GCP_DEPLOY}" == "1" ]]; then
  echo "Removing legacy Cloud Build trigger and Cloud Source mirror if present..."
  if gcloud builds triggers describe "${LEGACY_CLOUD_BUILD_TRIGGER_ID}" \
    --project="${PROJECT_ID}" >/dev/null 2>&1; then
    gcloud builds triggers delete "${LEGACY_CLOUD_BUILD_TRIGGER_ID}" \
      --project="${PROJECT_ID}" \
      --quiet
  fi

  if gcloud source repos describe "${LEGACY_CLOUD_SOURCE_REPO}" \
    --project="${PROJECT_ID}" >/dev/null 2>&1; then
    gcloud source repos delete "${LEGACY_CLOUD_SOURCE_REPO}" \
      --project="${PROJECT_ID}" \
      --quiet
  fi
fi

echo "Cloud Run CI/CD setup complete."
echo "Project: ${PROJECT_ID}"
echo "Region: ${REGION}"
echo "Service: ${SERVICE}"
echo "Artifact Registry image: ${REGION}-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_REGISTRY_REPOSITORY}/${SERVICE}:latest"
