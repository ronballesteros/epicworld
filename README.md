# EPIC WORLD
## LFG! :rocket: :rocket: :rocket:

I envision a world where life can and SHOULD be EPIC for everyone. Epic World is just the name of this infrastructure that installs the following:
- GKE cluster in Google Cloud
- FLUX for Kubernetes CI
- Lightning Network Daemon, Bitcoin Node (Bitcoind), and Monitoring (Grafana + Prometheus)

The cluster also uses Helm and Kustomize to deploy the application charts.

To administer the cluster and infrastructure, you will need to have the following tools installed:
- Terraform
- Kubectl
- Flux
- Helm
- Kustomize
- Make

### Folder Tree Layout

The following shows the folder tree layout:
```
├── EPICWORLD-README.md
├── Makefile
├── README.md
├── apps
│   ├── bitcoind
│   │   ├── kustomization.yaml
│   │   ├── namespace.yaml
│   │   ├── release.yaml
│   │   ├── repository.yaml
│   │   └── values.yaml
│   ├── kustomization.yaml
│   ├── lnd
│   │   ├── README.md
│   │   ├── kustomization.yaml
│   │   ├── namespace.yaml
│   │   ├── release.yaml
│   │   ├── repository.yaml
│   │   └── values.yaml
│   └── monitoring
│       ├── kustomization.yaml
│       ├── namespace.yaml
│       ├── release.yaml
│       ├── repository.yaml
│       └── values.yaml
├── backend.tf
├── bootstrap
│   ├── epicworld.yaml
│   ├── epicworldrepo.yaml
│   ├── kustomization.yaml
│   └── namespace.yaml
├── bootstrap.sh
├── flux
│   ├── gotk-components.yaml
│   └── kustomization.yaml
└── infra
    ├── main.tf
    ├── outputs.tf
    ├── terraform.tfstate
    ├── terraform.tfstate.backup
    └── variables.tf
```

### .envrc
.envrc is a useful tool extension for your bash shell which loads and unloads environment variables
depending on the current directory.  
This used for:
- Terraform credentials for Google Cloud.
- Github Repo token to allow Flux to clone the repository

This is required to be able to deploy/destroy resources on Google cloud and for Flux access.
Note:  there is a '.gitignore' file that includes the '.envrc' file extension to prevent from git commits

### Makefile
The makefile is included for easier deployment and installation of the infrastructure.  The make commands include:
```
make infra-init: INITIALIZE infrastructure Terraform code 

make infra-plan: PLAN infrastructure Terraform code

make infra-deploy: DEPLOY infrastructure Terraform code

make infra-destroy: DESTROY infrastructure Terraform code

make epicworld-deploy: DEPLOY Epicworld app on GKE

make destroy-bigbang: DESTROY Epicworld app on GKE
```

### Infrastructure
- Terraform that deploys a 3 node GKE cluster in Google Cloud.
- Outputs the kubeconfig to interact with the cluster.
- Note: A Google cloud project, Terraform service account, and storage are required to be created.

### Application
- A bootstrap script (bootstrap.sh) that will provision the necessary namespaces, helmreleases, pods, etc.
- Deployed using Helm referencing the upstream charts.
- Also utilizes kustomization for customizing the deployments.
- Flux is also deployed to watch the necessary changes on the /apps directory.