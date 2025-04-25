/*********************************************************************************************
  Terraform variable definitions for the production environment
  - Supplies all required input values for provider, modules, and resources
  - Sensitive values should be secured via environment variables or external vault
*********************************************************************************************/

# Provider variables are loaded from the OCI CLI config via `config_file_profile`
# and do not need to be specified here.
tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaarkd3tbphlab46jzmnnj5zesqj45cauldztg6pjbohw5enx7zn4lq"
user_ocid        = "ocid1.compartment.oc1..aaaaaaaapaafwwcnfrmhblvzqwlabrz2bf2rf33amwihcjc52ffg6m65zkpq"
fingerprint      = "d0:d3:50:4d:8a:b6:1f:b6:98:be:13:31:19:ec:b5:32"
private_key_path = "C:\\DevOps-Tools\\OCI\\.oci\\infra\\infra-manager-api-key-private.pem"
region           = "ap-hyderabad-1"


compartment_id = "ocid1.compartment.oc1..aaaaaaaapaafwwcnfrmhblvzqwlabrz2bf2rf33amwihcjc52ffg6m65zkpq"
image_id       = "ocid1.image.oc1.ap-hyderabad-1.aaaaaaaaifxjic3kbozmmo7kq52i6bka5hs2nd42a6wdaoczo24epl73jj4a"

# Compute sizing (override defaults if needed)
ocpus         = 2
memory_in_gbs = 12
