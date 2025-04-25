/*******************************************************************
  Network module input variables
  - Defines configuration for VCN, subnets, and security rules
*******************************************************************/

variable "compartment_id" {
  description = "OCID of the compartment where network resources will be created"
  type        = string
}

variable "vcn_name" {
  description = "Display name for the Virtual Cloud Network"
  type        = string
  default     = "zanybug"
}

variable "cidr_block" {
  description = "CIDR block for the VCN"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "allowed_ports" {
  description = "List of TCP ports to allow inbound traffic"
  type        = list(number)
  default     = [22, 80, 443, 3000, 5000, 5601, 8080, 9100]
}
