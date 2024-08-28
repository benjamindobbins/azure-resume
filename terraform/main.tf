
module "storage" {
  source              = "./modules/storage"
  storage_account_name = "bdresumestorage1337"
  resource_group_name  = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = {
    environment = "production"
    owner       = "team"
  }
}

module "cdn" {
  source              = "./modules/cdn"
  profile_name        = "bdresume-cdn"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  storage_account_endpoint = module.storage.primary_web_endpoint
  storage_account_name = module.storage.storage_account_name
  depends_on = [module.storage]

}

module "cosmosdb" {
    source = "./modules/cosmosdb"
    profile_name = "bdcosmosdb"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    storage_account_name = module.storage.storage_account_name



}

module "app" {
  source                     = "./modules/app"
  resource_group_name        = azurerm_resource_group.rg1.name
  storage_account_name       = module.storage.storage_account_name
  storage_account_access_key = module.storage.storage_account_primary_access_key
  service_plan_name          = "bdsp"
  azurerm_linux_function_app = "bdfunc1337"
  location                   = azurerm_resource_group.rg1.location
}
