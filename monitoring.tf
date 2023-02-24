resource "azurerm_monitor_diagnostic_setting" "diagnostics" {
  name               = var.diagnostic_settings_name
  target_resource_id = azurerm_service_plan.plan.id
  log_analytics_workspace_id = var.diag_log_analytics_workspace_id
  storage_account_id = var.diag_storage_account_id

  metric {
    category = "AllMetrics"
    enabled  = true
    retention_policy {
      days    = 30
      enabled = true
    }
  }
}