resource "azurerm_service_plan" "linux-service-plan" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_application_insights" "linux-application-insights" {
  name                = "application-insights-${var.azurerm_linux_function_app}"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "other"
}

resource "azurerm_linux_function_app" "linux-python-linux-function-app" {
  name                       = var.azurerm_linux_function_app
  resource_group_name        = var.resource_group_name
  location                   = var.location
  service_plan_id            = azurerm_service_plan.linux-service-plan.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  https_only                 = true

  site_config {
    application_insights_key = azurerm_application_insights.linux-application-insights.instrumentation_key
    application_stack {
      python_version = "3.11"
    }
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.linux-application-insights.instrumentation_key
  }
}