resource "random_string" "random" {
  length  = 3
  special = false
  upper   = false
  numeric = true
}