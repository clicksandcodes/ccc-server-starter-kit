# File: v1-tf-gha-test1a.tf

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

locals {
  sizes = {
    nano      = "s-1vcpu-1gb"
  }
  regions = {
    san_francisco = "sfo3"
  }
}

provider "digitalocean" {}

# the SERVER_NAME is not as important to set via env var... but we will go ahead and do it
variable "LINUX_SERVER_NAME" {
  type = string
  description = "environment variable for devops user"
  default = "blahServerName"
}

variable "LINUX_USER_DEVOPS" {
  type = string
  description = "environment variable for devops user"
  default = "blahLinxUser"
}

variable "LINUX_SSH_KEY" {
  type = string
  description = "environment variable for devops ssh key"
  default = "blahSshKey"
}

data "template_file" "my_example_user_data" {
  template = templatefile("./yamlScripts/tf-cloudinit-dev.yaml",
    {
      LINUX_USER_DEVOPS = "${var.LINUX_USER_DEVOPS}",
      LINUX_SSH_KEY = "${var.LINUX_SSH_KEY}",
    })
}

resource "digitalocean_droplet" "droplet" {
  image     = "ubuntu-22-04-x64"
  name      = "${var.LINUX_SERVER_NAME}"
  region    = local.regions.san_francisco
  size      = local.sizes.nano
  tags      = ["terraform", "docker"]
  user_data = data.template_file.my_example_user_data.rendered
}

output "ip_address" {
  value       = digitalocean_droplet.droplet.ipv4_address
  description = "The public IP address of your droplet."
}


output "template_file_contents" {
  value = data.template_file.my_example_user_data.rendered
}

output "LINUX_SERVER_NAME" {
  value = "${var.LINUX_SERVER_NAME}"
}

output "LINUX_USER_DEVOPS" {
  value = "${var.LINUX_USER_DEVOPS}"
}

output "LINUX_SSH_KEY" {
  value = "${var.LINUX_SSH_KEY}"
}