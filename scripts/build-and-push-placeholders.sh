#!/usr/bin/env bash
set -euo pipefail

# Container registry for placeholder images. Override by exporting REGISTRY before invoking this script.
REGISTRY="${REGISTRY:-ghcr.io/manganoconsulting}"

tools=(
  flightdynamics
  flightcontrol
  copilot
  simlab
  modelintegration
  devworkbench
)

for tool in "${tools[@]}"; do
  image_tag="$REGISTRY/${tool}-placeholder:latest"
  context_dir="infra/placeholders/${tool}"

  echo "Building image: ${image_tag} from ${context_dir}"
  docker build \
    -t "${image_tag}" \
    -f "${context_dir}/Dockerfile" \
    "${context_dir}"

  echo "Pushing image: ${image_tag}"
  docker push "${image_tag}"

done
