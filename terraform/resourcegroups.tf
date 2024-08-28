resource "azurerm_resource_group" "rg" {
  name     = "ResumeCDNStorage"
  location = "West US 2"
}
resource "azurerm_resource_group" "rg1" {
  name     = "ResumeApp"
  location = "West US 2"
}