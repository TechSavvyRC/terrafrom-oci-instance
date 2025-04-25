/****************************************************************************
  Compute module: launches application and ELK cluster instances
  - Creates VM.Standard.A1.Flex instances with specified resources
  - Installs Docker, Kubernetes components, and Python via cloud-init
****************************************************************************/

resource "oci_core_instance" "this" {
  count               = length(var.instance_names)
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  shape               = var.shape
  display_name        = var.instance_names[count.index]

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = var.image_id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = base64encode(<<-EOT
      #cloud-config
      package_update: true
      packages:
        - python3
        - python3-pip
        - curl
        - dnf-plugins-core
        - docker-ce
        - docker-ce-cli
        - containerd.io
        - dnf-utils
        - yum-utils

      write_files:
        - path: /etc/ssh/sshd_config
          append: true
          content: |
            ClientAliveInterval 300
            ClientAliveCountMax 12

      runcmd:
        - dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
        - dnf install -y docker-ce docker-ce-cli containerd.io
        - systemctl enable --now docker
        - usermod -aG docker opc
        - curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        - install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
        - curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
        - install -o root -g root -m 0755 minikube-linux-amd64 /usr/local/bin/minikube
        - systemctl restart sshd
        - echo "=== Python Version ==="
        - python3 --version
        - echo -e "\n=== Docker Version ==="
        - docker --version
        - echo -e "\n=== kubectl Version ==="
        - kubectl version --client --short
        - echo -e "\n=== Minikube Version ==="
        - minikube version
    EOT
    )
  }

  shape_config {
    ocpus         = var.ocpus
    memory_in_gbs = var.memory_in_gbs
  }
}
