/***************************************************************************
  Root production configuration
  - Generates an SSH key pair via the TLS provider
  - Invokes network, storage, and compute modules
***************************************************************************/

# 1. Generate an SSH key pair for instance access
resource "tls_private_key" "bootstrap" {
  algorithm = "RSA" # RSA algorithm for broad client compatibility
  rsa_bits  = 4096  # 4096-bit key for strong security
}

# Terraform dump the key to disk on every apply
resource "local_file" "private_key" {
  content         = tls_private_key.bootstrap.private_key_pem
  filename        = "${path.module}/tls_private_key.pem"
  file_permission = "0600"
}

# 2. Provision networking: VCN, subnets, and security lists
module "network" {
  source              = "../../modules/network" # Local network module
  compartment_id      = var.compartment_id
  vcn_name            = "zanybug"
  cidr_block          = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.0.0/24"]
  allowed_ports       = [22, 80, 443, 3000, 5000, 5601, 8080, 9100] # Least-privilege port list 
}

# 3. Provision storage: Object Storage bucket for artifacts and remote state
module "storage" {
  source         = "../../modules/storage" # Local storage module
  compartment_id = var.compartment_id
  bucket_name    = "zanybug"
}

# 4. Provision compute instances
module "compute" {
  source              = "../../modules/compute" # Local compute module
  compartment_id      = var.compartment_id
  availability_domain = "FFjv:AP-HYDERABAD-1-AD-1"
  subnet_id           = module.network.public_subnet_ids[0]
  ssh_public_key      = tls_private_key.bootstrap.public_key_openssh
  image_id            = var.image_id
  ocpus               = var.ocpus
  memory_in_gbs       = var.memory_in_gbs
}
