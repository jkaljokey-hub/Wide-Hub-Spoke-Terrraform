# Azure Hub-and-Spoke Network Architecture Using Terraform

**Azure Networking | Terraform | Infrastructure as Code | Azure Firewall | VNet Peering | Azure Bastion | Centralized Monitoring**

## Overview

This project demonstrates the design and deployment of a secure, scalable **Hub-and-Spoke network architecture in Microsoft Azure using Terraform**.

The objective is to centralize network security and traffic inspection while maintaining network segmentation between workload tiers. The infrastructure is defined as code, enabling repeatable deployments, version control, and consistent configuration across environments.

The architecture consists of a central hub virtual network hosting shared network services and two spoke virtual networks that separate web-tier and application-tier workloads.

### Architecture Diagram



## Architecture

The solution follows the Azure Hub-and-Spoke networking model.

- **Hub Virtual Network:** Centralizes shared networking and security services.
- **Web Spoke VNet:** Isolates web-tier workloads.
- **Application Spoke VNet:** Separates application-tier workloads.
- **VNet Peering:** Enables private connectivity between the hub and spoke networks.
- **Azure Firewall:** Provides centralized network traffic filtering and inspection.
- **User Defined Routes (UDRs):** Direct selected traffic through Azure Firewall.
- **Azure Bastion:** Enables secure virtual machine administration without public IP addresses on the VMs.
- **Azure Monitor and Log Analytics:** Support centralized monitoring and log analysis.



## Technologies Used

- Microsoft Azure
- Terraform
- HashiCorp Configuration Language (HCL)
- AzureRM Terraform Provider
- Azure Virtual Network
- VNet Peering
- Azure Firewall
- User Defined Routes
- Azure Bastion
- Azure Monitor
- Log Analytics
- Azure CLI
- Git and GitHub

## Key Engineering Objectives

### 1. Infrastructure as Code

Terraform defines the Azure infrastructure declaratively.

Benefits include:

- Repeatable infrastructure deployments.
- Version-controlled infrastructure configuration.
- Reusable resources and modules.
- Planned infrastructure changes before deployment.
- A foundation for CI/CD automation.

### 2. Network Segmentation

The web and application tiers are deployed in separate spoke VNets.

This separation supports independent network policies and controlled communication between workload tiers.

### 3. Centralized Network Security

Azure Firewall provides a central point for traffic inspection and filtering.

User Defined Routes direct selected traffic through the firewall, while configured firewall rules determine which traffic is permitted.

### 4. Secure Administrative Access

Azure Bastion provides administrative connectivity to supported VMs without requiring public IP addresses on those VMs.

Azure Bastion requires a dedicated subnet named `AzureBastionSubnet`. Azure Firewall requires a dedicated subnet named `AzureFirewallSubnet`.

### 5. Centralized Monitoring

Azure Monitor diagnostic settings can route supported resource logs to Log Analytics for investigation and troubleshooting.

The Log Analytics workspace is an Azure platform service and is not deployed inside a virtual network subnet.

## Terraform Project Structure

A possible repository structure is:

```text
azure-hub-spoke-terraform/
├── versions.tf
├── providers.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
├── modules/
│   ├── hub-vnet/
│   ├── spoke-vnet/
│   ├── vnet-peering/
│   ├── azure-firewall/
│   ├── route-tables/
│   ├── azure-bastion/
│   └── diagnostics/
├── docs/
│   └── architecture.png
├── .gitignore
└── README.md
```

Adapt this structure to the actual files in the repository. Terraform modules should reflect reusable components that are genuinely implemented.

## Prerequisites

Before deployment, ensure you have:

- An active Azure subscription.
- Azure CLI installed.
- Terraform installed.
- An Azure account with the permissions required to create the resources.
- Git installed.
- Appropriate Azure resource quotas and an approved deployment region.

## Deployment Guide

The following commands assume that the root directory contains the Terraform configuration. Adjust file names and variables to match the actual implementation.

### 1. Authenticate with Azure

```bash
az login
az account set --subscription "<SUBSCRIPTION_ID>"
```

### 2. Initialize Terraform

```bash
terraform init
```

This initializes the working directory and downloads the required providers and modules.

### 3. Validate the configuration

```bash
terraform fmt -recursive
terraform validate
```

`terraform fmt` formats Terraform files, while `terraform validate` checks the configuration for structural and syntax issues.

### 4. Review the deployment plan

```bash
terraform plan -out=tfplan
```

Review the proposed infrastructure changes before applying them.

If the project requires a variable file, use the appropriate command, for example:

```bash
terraform plan -var-file="terraform.tfvars" -out=tfplan
```

Do not commit sensitive values in `terraform.tfvars`.

### 5. Deploy the infrastructure

```bash
terraform apply tfplan
```

Terraform creates or updates resources according to the reviewed plan.

### 6. Review outputs

```bash
terraform output
```

Use the outputs defined by the project to inspect relevant resource names, IDs, or network information.

## Validation and Testing

After deployment, validate the actual network configuration.

- Confirm that all VNets have the expected address spaces.
- Verify that VNet peerings are connected.
- Confirm that Azure Firewall is deployed in its dedicated subnet.
- Verify firewall rules and policies.
- Confirm that route tables are associated with the intended subnets.
- Check that routes use the correct firewall private IP where traffic inspection is required.
- Verify Azure Bastion deployment and connectivity.
- Test permitted and denied traffic paths using suitable test workloads.
- Confirm that diagnostic settings send supported logs to the configured destination.
- Review Terraform outputs and Azure Activity Logs for deployment errors.

A successful Terraform apply confirms that Azure accepted the resource operations. It does not, by itself, prove that every traffic path behaves as intended.

## Security Considerations

- Avoid assigning public IP addresses to workload VMs unless required.
- Use Azure Bastion or another approved administrative access method.
- Apply least-privilege Azure RBAC permissions.
- Restrict firewall rules to required sources, destinations, protocols, and ports.
- Configure route tables and peering deliberately.
- Use non-overlapping IP address spaces.
- Enable appropriate diagnostic settings.
- Never commit credentials, access keys, or secrets to GitHub.
- Protect Terraform state because it can contain sensitive resource information.
- Use remote state with appropriate access controls and state locking where supported by the selected backend.

## Cost Management

Azure Firewall and Azure Bastion can incur ongoing charges. Other deployed resources may also generate costs depending on configuration and usage.

Before deployment:

- Review current Azure pricing.
- Use a dedicated lab resource group.
- Avoid leaving expensive resources running unnecessarily.
- Inspect resources before deleting them.
- Keep Terraform state and Azure resources synchronized.

**Important:** `terraform destroy` can delete all resources managed by the selected Terraform configuration. Review the plan and confirm the target environment before running it.

## Future Enhancements

Potential improvements include:

- Automated Terraform validation through GitHub Actions.
- Separate development, staging, and production environments.
- Reusable Terraform modules with input validation.
- Remote state management with controlled access.
- Azure Policy for governance and compliance.
- Automated network connectivity tests.
- Centralized alerting and monitoring.
- Private endpoints and private DNS for supported Azure services.
- Automated cost checks and deployment approval gates.

These are proposed enhancements unless they are already implemented in the repository.

## Learning Outcomes

This project demonstrates practical exploration of:

- Azure Hub-and-Spoke network architecture.
- Terraform-based Infrastructure as Code.
- Network segmentation and VNet peering.
- Centralized network security using Azure Firewall.
- Traffic steering through User Defined Routes.
- Secure VM administration using Azure Bastion.
- Azure resource monitoring and diagnostics.
- Terraform planning, validation, and deployment workflows.

## Author

**Cloud Engineering Portfolio Project**

Focus areas: Cloud Infrastructure, Azure Networking, Terraform, Infrastructure as Code, and Cloud Security.

- **GitHub:** Add your repository URL.
- **LinkedIn:** Add your profile URL.

---

**Disclaimer:** This is a portfolio and learning project. Production readiness depends on the implemented configuration, security controls, testing, monitoring, and operational procedures.
