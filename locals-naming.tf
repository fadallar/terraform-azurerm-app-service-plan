locals {
 
  service_slug           = "asp"
  landing_zone_slug      = var.landing_zone_slug
  application_id         = var.stack
  workload_info          = var.workload_info
  #environment            = var.environment
  location_short         = var.location_short
  separator              = "-"
  generated_random_value = random_string.random.result
  name_components_list   = compact([local.service_slug, local.landing_zone_slug, local.location_short, local.application_id, local.workload_info, local.generated_random_value])
  standard_name          = join(local.separator, local.name_components_list)
  name                   = coalesce(lower(var.custom_name), lower(local.standard_name))
}
