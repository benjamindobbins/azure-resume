output "primary_web_endpoint" {
  value = azurerm_storage_account.storage.primary_web_endpoint
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "storage_account_primary_access_key" {
  value = azurerm_storage_account.storage.primary_access_key
}