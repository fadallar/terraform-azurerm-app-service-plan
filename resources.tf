resource "azurerm_service_plan" "plan" {
  name = local.app_service_plan_name

  location            = var.location
  resource_group_name = var.resource_group_name

  os_type  = var.os_type
  sku_name = var.sku_name

  worker_count                 = var.sku_name == "Y1" ? null : var.worker_count
  #Not applicable unless sku is an elastic sku EP1, EP2, or EP3
  #Elastic sku are usable by function app
  maximum_elastic_worker_count = var.maximum_elastic_worker_count
  # Required by Isolated service plan
  app_service_environment_id = var.app_service_environment_id
  per_site_scaling_enabled   = var.per_site_scaling_enabled

  tags = merge(variable.default_tags, var.extra_tags)
}
