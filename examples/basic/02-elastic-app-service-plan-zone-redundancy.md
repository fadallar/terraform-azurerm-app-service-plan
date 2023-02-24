# Basic Azure Application Service PLan

This is an example for setting-up a an Elastic App Service Plan to be used by Azure Function App
 This example
  - Sets the different Azure Region representation ( location, location_short, location_cli ...) --> module "regions_master"
  - Instanciates a map object with the common Tags ot be applied to all resources --> module "base_tagging"
  - A resource-group --> module "ressource" 
  - Creates an Application Service Plan with Elastic Service Plan and zone redundancy
  - Set the default diagnostics settings (All Logs and metric) whith a Log Analytics workspace as destination 

## Main.tf file content
  Please replace the modules source and version with your relevant information  

```hcl
// Core modules

module "regions_master" {
  source  = "app.terraform.io/<ORGANIZATION>/regions-master/azurem"
  version = "x.y.z"
  azure_region = var.location # example eu-west
}

module "base_tagging" {
  source  = "app.terraform.io/<ORGANIZATION>/base-tagging/azurerm"
  version = "x.y.z"
  environment = var.environment
  stack = var.stack
  spoc =  var.spoc
  change = var.change
  costcenter = var.costcenter
  owner = var.owner
}

// Resource Group
module "ressource" {
    source  = "app.terraform.io/<ORGANIZATION>/rg/azurerm"
    version = "x.y.z"
    environment = var.environment
    stack       = var.stack
    location    = module.regions_master.location
    location_short = module.regions_master.location_short
}

module "app_service_plan" {
  source  = "app.terraform.io/<ORGANIZATION>/app-service-plan/azurerm"
  version = "x.y.z"
  environment = var.environment
  landing_zone_slug = var.landing_zone_slug
  stack       = var.stack
  location                        = module.regions_master.location
  location_short                  = module.regions_master.location_short
  resource_group_name             = module.rg.resource_group_name
  default_tags                    = module.base-tagging.base_tags

  diag_log_analytics_workspace_id = ""    #### Log Analytics Workspace Resource Id
  // App service Plan specific configuration
  os_type = "Linux"
  sku_name = "P1v2"
  worker_count = 6  # it must be a multiple of the number of AZ in the region
  zone_redundancy = true
}
```