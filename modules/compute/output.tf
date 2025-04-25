/****************************************************************************
  Compute module outputs
  - Exposes identifiers and public IPs of the compute instances
****************************************************************************/

output "instance_ids" {
  description = "List of OCIDs for the compute instances"
  value       = oci_core_instance.this[*].id
}

output "instance_public_ips" {
  description = "List of public IP addresses for the compute instances"
  value       = oci_core_instance.this[*].public_ip
}

# Build a map of name => IP within the module
output "instance_name_ip_map" {
  description = "Map of each instance name to its public IP"
  value = {
    for idx, name in var.instance_names :
    name => oci_core_instance.this[idx].public_ip
  }
}

