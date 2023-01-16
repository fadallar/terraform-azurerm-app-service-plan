// Please check issue https://github.com/hashicorp/terraform-provider-azurerm/issues/17172

data "azurerm_monitor_diagnostic_categories" "diagcategories" {
  resource_id = azurerm_service_plan.plan.id
}

resource "azurerm_monitor_diagnostic_setting" "diagnostics" {
  name               = "default-Diagnostics-Logs"
  target_resource_id = azurerm_service_plan.plan.id
  log_analytics_workspace_id = var.diag_log_analytics_workspace_id

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.diagcategories.metrics
    content {
      category = metric.value
      enabled  = true
      retention_policy {
        days    = 30
        enabled = true
      }
    }
  }
  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.diagcategories.log_category_types
    content {
      category = log.value
      enabled  = true
      retention_policy {
        days    = 30
        enabled = true
      }
    }
  }
}