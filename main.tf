terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# A provider is a plugin in Terraform that allows it to interact with APIs and manage resources for a specific platform like Azure. It will use the provider to talk to the cloud service and create the infrastructure we have described.


resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.location
}

# Creates a resource group, which is a logical container for our Azure resources. It allows us to group and manage resources as a single entity, simplifying deployment, access control and cleanup

resource "azurerm_storage_account" "storage" {
    name = var.storage_account_name
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    account_tier = "Standard" # Performance level (Standard or Premium)
    account_replication_type = "LRS" # Redundancy level (LRS, GRS, etc.)
    # LRS - 3 copies of your data in a single data centre within a region
    # DOCS: https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy 
    static_website {
        index_document = "index.html"
    } # Enables static website hosting with index.html as the homepage
}

# Creates a storage account in the resource group. It is like a cloud-based hard drive on Azure. Gives us access to secure, scalable, and redundant storage for all kinds of data, such as files (images, videos, docs), backup and logs, application data, website assets



resource "azurerm_storage_blob" "index_html" {
    name = "index.html"
    storage_account_name = azurerm_storage_account.storage.name
    storage_container_name = "$web"
    type = "Block" # Defines the blob type
    source = "${path.module}/website/index.html" # Path to the local file we are uploading
    content_type = "text/html" # Used by brosers to interpret the file

}

# Uploads the index.html file to the special $web container, which is automatically created when you enable static web hosting