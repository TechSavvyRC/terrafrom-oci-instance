/*******************************************************************************************
  OCI provider configuration for the development environment
  - Uses the INFRA profile from C:\DevOps-Tools\OCI\.oci\config for authentication
  - References root-level input variables declared in variables.tf
*******************************************************************************************/

terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 5.0"
    }
  }
}

provider "oci" {
  config_file_profile = "INFRA" // Profile in C:\DevOps-Tools\OCI\.oci\config to use

  tenancy_ocid     = var.tenancy_ocid     // OCID of the OCI tenancy
  user_ocid        = var.user_ocid        // OCID of the OCI user
  fingerprint      = var.fingerprint      // Fingerprint of the API key
  private_key_path = var.private_key_path // Path to the private key file
  region           = var.region           // OCI region
}
