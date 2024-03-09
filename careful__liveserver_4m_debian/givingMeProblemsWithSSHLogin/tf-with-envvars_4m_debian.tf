# tf with env vars fed from OS CLI

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
variable "LINUX_SERVER_NAME_4m_debian" {
  type = string
  description = "environment variable for devops user"
  default = "blahServerName"
}

variable "LINUX_USER_DEVOPS_4m_debian" {
  type = string
  description = "environment variable for devops user"
  default = "blahLinxUser"
}

variable "LINUX_SSH_KEY_4m_debian" {
  type = string
  description = "environment variable for devops ssh key"
  default = "blahSshKey"
}

data "template_file" "my_example_user_data" {
  template = templatefile("./yamlScripts/with-envVars.yaml",
    {
      LINUX_USER_DEVOPS_4m_debian = "${var.LINUX_USER_DEVOPS_4m_debian}",
      LINUX_SSH_KEY_4m_debian = "${var.LINUX_SSH_KEY_4m_debian}",
    })
}

resource "digitalocean_droplet" "droplet" {
  image     = "debian-12-x64"
  name      = "${var.LINUX_SERVER_NAME_4m_debian}"
  region    = local.regions.san_francisco
  size      = local.sizes.nano
  tags      = ["terraform", "docker"]
  user_data = data.template_file.my_example_user_data.rendered
}

output "ip_address" {
  value       = digitalocean_droplet.droplet.ipv4_address
  description = "The public IP address of your droplet."
}

output "tf_apply_timestamp" {
  value       = timestamp()
  description = "Timestamp of apply"
}

# https://www.tinfoilcipher.co.uk/2020/10/19/terraform-tricks-working-with-timestamps/
locals {
    current_timestamp  = timestamp()
    current_day        = formatdate("YYYY-MM-DD", local.current_timestamp)
    current_time       = formatdate("hh:mm:ss", local.current_timestamp)
    current_day_name   = formatdate("EEEE", local.current_timestamp)
}

output "current_timestamp" {
    value = local.current_timestamp
}
output "current_day" {
    value = local.current_day
}
output "current_time" {
    value = local.current_time
}
output "current_day_name" {
    value = local.current_day_name
}

# If you want to make sure the yaml file was properly filled with env vars, you can uncomment this output statement and terraform will show the env vars in situ
# output "template_file_contents" {
#   value = data.template_file.my_example_user_data.rendered
# }

# output "LINUX_SERVER_NAME_4m_debian" {
#   value = "${var.LINUX_SERVER_NAME_4m_debian}"
# }

# output "LINUX_USER_DEVOPS_4m_debian" {
#   value = "${var.LINUX_USER_DEVOPS_4m_debian}"
# }

# output "LINUX_SSH_KEY_4m_debian" {
#   value = "${var.LINUX_SSH_KEY_4m_debian}"
# }