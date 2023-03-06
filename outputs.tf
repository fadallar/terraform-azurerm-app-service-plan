output "service_plan_id" {
  description = "ID of the created Service Plan"
  value       = azurerm_service_plan.this.id
}

output "service_plan_kind" {
  description = "Service Plan Kind"
  value = azurerm_service_plan.this.kind
}

output "service_plan_reserved" {
  description = "Is service plan reserved. True if the plan is for Linux"
  value = azurerm_service_plan.this.reserved
}

output "service_plan_name" {
  description = "Name of the created Service Plan"
  value       = azurerm_service_plan.this.name
}

output "service_plan_location" {
  description = "Azure location of the created Service Plan"
  value       = azurerm_service_plan.this.location
}
