/**********************************************************************************
  Production environment outputs
  - Exposes key resource identifiers for downstream use and visibility
**********************************************************************************/

# Virtual Cloud Network
output "vcn_id" {
  description = "OCID of the created Virtual Cloud Network (VCN)"
  value       = module.network.vcn_id
}

# Public Subnet IDs
output "public_subnet_ids" {
  description = "List of OCIDs for public subnets created"
  value       = module.network.public_subnet_ids
}

# Compute Instance Public IPs
output "instance_public_ips" {
  description = "List of public IP addresses for the compute instances"
  value       = module.compute.instance_public_ips
}

# Object Storage Bucket
output "bucket_id" {
  description = "OCID of the Object Storage bucket"
  value       = module.storage.bucket_id
}

output "bucket_name" {
  description = "Name of the Object Storage bucket"
  value       = module.storage.bucket_name
}

# SSH Private Key Material
output "ssh_private_key_pem" {
  description = "PEM-encoded private key generated for SSH access (sensitive)"
  value       = tls_private_key.bootstrap.private_key_pem
  sensitive   = true
}

output "instance_name_ip_map" {
  description = "Map of instance display names to their public IP addresses"
  value       = module.compute.instance_name_ip_map
}
