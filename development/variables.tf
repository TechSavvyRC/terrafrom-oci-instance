/*******************************************************************************************************
  Production environment input variables
  - Defines all variables required to configure provider, modules, and resources
  - Ensures no sensitive defaults; values must be provided via terraform.tfvars or environment
*******************************************************************************************************/

# OCI Provider credentials
variable "tenancy_ocid" {
  description = "OCID of the OCI tenancy"
  type        = string
}

variable "user_ocid" {
  description = "OCID of the OCI user"
  type        = string
}

variable "fingerprint" {
  description = "Fingerprint of the OCI API key"
  type        = string
}

variable "private_key_path" {
  description = "Path to the OCI API private key file"
  type        = string
}

variable "region" {
  description = "OCI region identifier (e.g., us-ashburn-1)"
  type        = string
}

# Core infrastructure identifiers
variable "compartment_id" {
  description = "OCID of the target compartment"
  type        = string
}

variable "image_id" {
  description = "OCID of the Oracle Linux 9 image (e.g., 2025.03.18-0 build)"
  type        = string
}

# Compute sizing (within Always Free limits)
variable "ocpus" {
  description = "Number of OCPUs for each VM.Standard.A1.Flex instance"
  type        = number
  default     = 1
}

variable "memory_in_gbs" {
  description = "Memory size in GB for each VM.Standard.A1.Flex instance"
  type        = number
  default     = 12
}
