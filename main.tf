resource "azurerm_service_plan" "plan" {
  name = local.name
  location            = var.location
  resource_group_name = var.resource_group_name

  os_type  = var.os_type
  sku_name = var.sku_name
  worker_count                 = var.sku_name == "Y1" ? null : var.worker_count
  zone_balancing_enabled      = var.zone_balancing_enabled
  
  #Not applicable unless sku is an elastic sku EP1, EP2, or EP3
  #Elastic sku are usable by function app
  maximum_elastic_worker_count = contain(["EP1","EP2","EP3"],var.sku_name) ? var.maximum_elastic_worker_count : null
  
  # Required by Isolated service plan
  app_service_environment_id = containe(["I1", "I2", "I3", "I1v2", "I2v2", "I3v2"],var.sku_name) ? var.app_service_environment_id : null
  per_site_scaling_enabled   = var.per_site_scaling_enabled

  tags = merge(var.default_tags, var.extra_tags)
}