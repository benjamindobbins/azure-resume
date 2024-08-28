output "function_app_id" {
  value = azurerm_linux_function_app.linux-python-linux-function-app.id
}

output "function_app_default_hostname" {
  value = azurerm_linux_function_app.linux-python-linux-function-app.default_hostname
}