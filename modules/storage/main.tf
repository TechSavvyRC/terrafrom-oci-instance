/******************************************************************************************
  Storage module: Always Free Object Storage Bucket
  - Creates an object storage bucket optimized for Terraform state and artifacts
  - Ensures bucket is in the correct compartment and has versioning enabled
******************************************************************************************/

resource "oci_objectstorage_bucket" "this" {
  compartment_id = var.compartment_id
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  name           = var.bucket_name

  versioning = "Enabled"

  # Apply default retention settings if needed (optional)
  # retention_rule {
  #   retention_rule_type = "DAYS"
  #   days = 30
  # }
}

# Fetch Object Storage namespace (global)
data "oci_objectstorage_namespace" "ns" {}
