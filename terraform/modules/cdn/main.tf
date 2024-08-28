

# Define the CDN Profile
resource "azurerm_cdn_profile" "cdn_profile" {
  name                = "bdresume-cdnprofile"
  resource_group_name = var.resource_group_name
  location            = "Global"
  sku                 = "Standard_Microsoft"

}

# Define the CDN Endpoint
resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = "bdresume-endpoint"
  profile_name        = azurerm_cdn_profile.cdn_profile.name
  resource_group_name = var.resource_group_name
  location            = "Global"
  origin {
    name      = "default-origin"
    host_name = "${var.storage_account_name}.z5.web.core.windows.net"
  }
  is_http_allowed     = true
  is_https_allowed    = true
  content_types_to_compress = [
    "application/eot",
    "application/font",
    "application/javascript",
    "text/html",
    "text/css"
  ]
origin_host_header = "${var.storage_account_name}.z5.web.core.windows.net"
}

# Define the Custom Domain for the CDN Endpoint
resource "azurerm_cdn_endpoint_custom_domain" "bendobbins_custom_domain" {
  name            = "www-bendobbins-cloud"
  cdn_endpoint_id = azurerm_cdn_endpoint.cdn_endpoint.id
  host_name       = "www.bendobbins.cloud"
}