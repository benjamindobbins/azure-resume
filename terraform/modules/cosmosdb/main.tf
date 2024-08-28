resource "azurerm_cosmosdb_account" "bdcosmosdb" {
  name                = "bdcosmosdb"
  resource_group_name = var.resource_group_name
  location            = var.location
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  capabilities {
    name = "EnableTable"
  }
  capabilities {
    name = "EnableServerless"
  }
  geo_location {
    location          = "West US 2"
    failover_priority = 0
  }
  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 86400
    max_staleness_prefix    = 1000000
  }
}

resource "azurerm_cosmosdb_table" "VisitCounterTable" {
  name                = "VisitCounter"
  resource_group_name = azurerm_cosmosdb_account.bdcosmosdb.resource_group_name
  account_name        = azurerm_cosmosdb_account.bdcosmosdb.name
}