
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable  "storage_account_name" {
    description = "The storage account endpoint"
    type = string
}

variable "location" {
  description = "The location of the storage account"
  type        = string
}

variable "profile_name" {
  description = "The name of the CDN profile"
  type        = string
}