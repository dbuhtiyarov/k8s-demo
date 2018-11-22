# Repo for Atlassian k8s demo

that project is vanilla installation Atlassian stack into k8s

### Terraform

Create a structure like

```
~/.gcp/
account.json
backend-dev.conf
dev.tfvars
```
Run terraform as

```
terraform init -backend-config=~/.gcp/backend-dev.conf
terraform plan -var-file=~/.gcp/dev.tfvars
terraform apply -var-file=~/.gcp/dev.tfvars
```
