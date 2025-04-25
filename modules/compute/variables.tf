/*********************************************************************
  Compute module input variables
  - Defines configuration for launching compute instances
*********************************************************************/

variable "compartment_id" {
  description = "OCID of the compartment where compute instances will be created"
  type        = string
}

variable "availability_domain" {
  description = "Availability domain to launch the instances in"
  type        = string
}

variable "subnet_id" {
  description = "OCID of the subnet to attach the instances to"
  type        = string
}

variable "image_id" {
  description = "OCID of the image to use for the instances"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key to be injected into the instances"
  type        = string
}

variable "shape" {
  description = "Shape of the compute instances"
  type        = string
  default     = "VM.Standard.E5.Flex"
  #default = "VM.Standard.A1.Flex"
}

variable "ocpus" {
  description = "Number of OCPUs for the compute instances"
  type        = number
  default     = 1
}

variable "memory_in_gbs" {
  description = "Amount of memory (in GB) for the compute instances"
  type        = number
  default     = 12
}

variable "instance_names" {
  description = "List of names for the compute instances"
  type        = list(string)
  default     = ["otel-demo-app", "elk-cluster"]
}
