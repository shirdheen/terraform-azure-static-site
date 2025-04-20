# Using Terraform input variables, which are a powerful way to parameterize infrastructure code (can be reused with different values)

variable "resource_group_name" {
  default = "tf-static-site-rg" # If no value is passed at runtime, Terraform will use the default value
}

variable "location" {
  default = "Australia East" # Azure region
}

variable "storage_account_name" {
  default = "tfstaticwebproject123"
}

variable "tenant_id" {
  description = "Azure tenant ID"
}

variable "object_id" {
  description = "Object ID of user of or service principal"
}
