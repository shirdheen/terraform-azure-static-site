# Terraform on Azure: Static Website Deployment with CI/CD

This project demonstrates how to deploy a static website to **Azure Blob Storage** using **Terraform**, with **Github Actions CI/CD** for continuous validation and planning.

![CI](https://github.com/shirdheen/terraform-azure-static-site/actions/workflows/deploy.yml/badge.svg)

---

## What This Project Does

- Creates an **Azure Resource Group**
- Creates an **Azure Storage Account** with static website hosting enabled
- Uploads a simple `index.html` to the `$web` container
- Automates a `terraform init`, `fmt`, `validate`, and `plan` using **GitHub Actions**
- Uses a **Service Principal** for secure authentication via GitHub Secrets

---

## Tools and Technologies

- [Terraform](https://developer.hashicorp.com/terraform)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Azure Resource Manager (azurerm) Provider](https://docs.github.com/en/actions)

---

## GitHub Actions: CI/CD Pipeline

- Located in `.github/workflows/deploy.yml`
- Runs on:
  - Every push to `main`
  - Every pull request
- Steps
  - `terraform init`
  - `terraform fmt -check`
  - `terraform validate`
  - `terraform plan`

### Manual Deployment

This project supports manual deployment using the **Run Workflow** feature.

To deploy to Azure:

1. Go to **Actions > Terraform CI/CD**
2. Click **Run Workflow**
3. GitHub Actions will apply the Terraform plan and deploy resources

---

## Authentication via GitHub Secrets

- A **Service Principal** was created using:

```bash
az ad sp create-for-rbac --name "github-terraform-sp" --role="Contributor" --scopes="/subscriptions/<subscription-id>" --sdk-auth
```

- JSON output stored as a GitHub Secret named: `AZURE_CREDENTIALS`

---

## Output

Once deployed, the site is publicly accessible at the endpoint Terraform outputs:

```hcl
output "static_website_url" {
  value = azurerm_storage_account.storage.primary_web_endpoint
}
```

---

## Cleanup

To destroy all resources created:

```bash
terraform destroy
```
