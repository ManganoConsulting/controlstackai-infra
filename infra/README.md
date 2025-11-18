# ControlStackAI placeholder services

This folder deploys placeholder nginx services for ControlStackAI tools. Replace `<REGISTRY>` with your container registry (for example `ghcr.io/ManganoConsulting`) when building and pushing the images.

## Build and push images

From the repo root:

```bash
# Flight Dynamics
cd infra/placeholders/flightdynamics
REGISTRY=<REGISTRY>
docker build -t "$REGISTRY/flightdynamics-placeholder:latest" .
docker push "$REGISTRY/flightdynamics-placeholder:latest"

# Flight Control
cd ../flightcontrol
docker build -t "$REGISTRY/flightcontrol-placeholder:latest" .
docker push "$REGISTRY/flightcontrol-placeholder:latest"

# Compliance Co-Pilot
cd ../copilot
docker build -t "$REGISTRY/copilot-placeholder:latest" .
docker push "$REGISTRY/copilot-placeholder:latest"

# Simulation Lab
cd ../simlab
docker build -t "$REGISTRY/simlab-placeholder:latest" .
docker push "$REGISTRY/simlab-placeholder:latest"

# Model Integration
cd ../modelintegration
docker build -t "$REGISTRY/modelintegration-placeholder:latest" .
docker push "$REGISTRY/modelintegration-placeholder:latest"

# Dev Workbench
cd ../devworkbench
docker build -t "$REGISTRY/devworkbench-placeholder:latest" .
docker push "$REGISTRY/devworkbench-placeholder:latest"
```

## Deploy to Kubernetes

Apply the manifests in order:

```bash
kubectl apply -f infra/k8s/cs-tools-namespace.yaml
kubectl apply -f infra/k8s/cs-tools-deployments.yaml
kubectl apply -f infra/k8s/cs-tools-ingress.yaml
```

## DNS and TLS

Configure DNS in Cloudflare so each subdomain points to your cluster's Ingress or load balancer:

- `flightdynamics.controlstackai.com`
- `flightcontrol.controlstackai.com`
- `copilot.controlstackai.com`
- `simlab.controlstackai.com`
- `modelintegration.controlstackai.com`
- `dev.controlstackai.com`

Ensure TLS is handled either by cert-manager issuing the `controlstackai-tools-tls` secret or by terminating TLS at Cloudflare and forwarding HTTP to the cluster.
