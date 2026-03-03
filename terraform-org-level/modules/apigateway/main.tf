resource "google_api_gateway_api" "api" {
  for_each = var.gateway_names
  api_id   = each.key
}

resource "google_api_gateway_api_config" "api_config" {
  for_each = var.gateway_names
  api      = google_api_gateway_api.api[each.key].name
  api_config_id = "${each.key}-config"
  openapi_documents {
    documenrt {
      path = "openapi.yaml"
    }
  }
}
