resource "google_bigquery_dataset" "datasets" {
  for_each   = var.datasets
  dataset_id = each.key
  location   = each.value.location
}

resource "google_bigquery_table" "tables" {
  for_each = { for ds_name, ds in var.datasets : ds_name => ds.tables... }

  dataset_id = each.key
  table_id   = each.value
  schema     = file("schema.json")
}

