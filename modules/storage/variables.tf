/*******************************************************************
  Storage module input variables
  - Defines compartment and bucket name for object storage
*******************************************************************/

variable "compartment_id" {
  description = "OCID of the compartment where the bucket will be created"
  type        = string
}

variable "bucket_name" {
  description = "Display name for the Object Storage bucket"
  type        = string
  default     = "zanybug"
}
