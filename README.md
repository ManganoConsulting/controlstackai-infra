# controlstackai-infra

Infrastructure manifests and tooling for ControlStack AI placeholder services.

## Building and pushing placeholder images

Before building and pushing images, log in to GitHub Container Registry (GHCR):

```bash path=null start=null
docker login ghcr.io -u ManganoConsulting
```

You will be prompted for a Personal Access Token (PAT) with appropriate `write:packages` / `read:packages` scopes.

From the repo root, build and push all placeholder images with:

```bash path=null start=null
scripts/build-and-push-placeholders.sh
```

By default, images are pushed to `ghcr.io/manganoconsulting`. You can override the registry by setting the `REGISTRY` environment variable when invoking the script.

## Deploying to a cluster

Once the images are available in your registry, you can deploy the placeholder services to a Kubernetes cluster with:

```bash path=null start=null
kubectl apply -f infra/k8s/cs-tools-namespace.yaml
kubectl apply -f infra/k8s/cs-tools-deployments.yaml
kubectl apply -f infra/k8s/cs-tools-ingress.yaml
```

Notes:

- The target cluster must already have an Ingress controller installed.
- DNS for the subdomains (e.g. `flightdynamics.controlstackai.com`, `flightcontrol.controlstackai.com`, `copilot.controlstackai.com`, etc.) must point to the cluster's Ingress/load balancer endpoint.
- TLS for the `controlstackai-tools-tls` secret can be handled via cert-manager (issuing certificates in-cluster) or by terminating TLS at Cloudflare and forwarding HTTP(S) to the cluster as appropriate.
