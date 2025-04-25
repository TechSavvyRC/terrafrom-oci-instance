/**********************************************************************************************
  Network module: VCN, Public Subnets, Internet Gateway, Route Table, and Security Lists
  - Creates a VCN with specified CIDR block
  - Provisions public subnets and associates them with route tables
  - Opens only the allowed ports via security lists (least-privilege)
**********************************************************************************************/

resource "oci_core_virtual_network" "vcn" {
  compartment_id = var.compartment_id
  display_name   = var.vcn_name
  cidr_block     = var.cidr_block
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_id
  display_name   = "${var.vcn_name}-igw"
  vcn_id         = oci_core_virtual_network.vcn.id
}

resource "oci_core_route_table" "rt" {
  compartment_id = var.compartment_id
  display_name   = "${var.vcn_name}-rt"
  vcn_id         = oci_core_virtual_network.vcn.id

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_subnet" "public" {
  count                      = length(var.public_subnet_cidrs)
  compartment_id             = var.compartment_id
  display_name               = "${var.vcn_name}-pub-${count.index + 1}"
  vcn_id                     = oci_core_virtual_network.vcn.id
  cidr_block                 = var.public_subnet_cidrs[count.index]
  route_table_id             = oci_core_route_table.rt.id
  prohibit_public_ip_on_vnic = false
}

resource "oci_core_security_list" "sl" {
  compartment_id = var.compartment_id
  display_name   = "${var.vcn_name}-sl"
  vcn_id         = oci_core_virtual_network.vcn.id

  # Ingress blocks, one per port
  dynamic "ingress_security_rules" {
    for_each = var.allowed_ports
    content {
      protocol = "6"
      source   = "0.0.0.0/0"
      tcp_options {
        min = ingress_security_rules.value
        max = ingress_security_rules.value
      }
    }
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}
