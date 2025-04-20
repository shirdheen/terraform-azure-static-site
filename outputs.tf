# Terraform output block - used to display values after a Terraform run - like URLs, IP addresses, or resource names

output "static_website_url" {
  value = azurerm_storage_account.storage.primary_web_endpoint

  # primary_web_endpoint attribute - built-in property of the Azure Storage Account when static website hosting is enabled
}

# Value is set to the public URL of my Azure static website (comes from the azure_storage_account) resource we defined earlier

output "key_vault_uri" {
  value       = azurerm_key_vault.kv.vault_uri
  description = "URI of the Azure Key Vault"
}
