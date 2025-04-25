/**********************************************************************************************
  Network module outputs
  - Exposes identifiers for VCN, subnets, and security list for use by root modules
**********************************************************************************************/

output "vcn_id" {
  description = "OCID of the created Virtual Cloud Network (VCN)"
  value       = oci_core_virtual_network.vcn.id
}

output "public_subnet_ids" {
  description = "List of OCIDs for the public subnets"
  value       = oci_core_subnet.public[*].id
}

output "security_list_id" {
  description = "OCID of the security list enforcing allowed ports"
  value       = oci_core_security_list.sl.id
}
