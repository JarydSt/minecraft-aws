variable "aws_region" {
  description = "AWS region used by the AWS Academy Learner Lab."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix for AWS resources."
  type        = string
  default     = "minecraft-iac"
}

variable "instance_type" {
  description = "EC2 instance type. t2.micro is low cost but limited, so the Ansible playbook adds swap."
  type        = string
  default     = "t2.micro"
}

variable "admin_cidr" {
  description = "Your public IP address in CIDR notation, for example 203.0.113.10/32. Used for SSH/Ansible and Minecraft/nmap access."
  type        = string
}

variable "public_key_path" {
  description = "Path to the SSH public key Terraform will upload to AWS as an EC2 key pair."
  type        = string
  default     = "../.ssh/minecraft_key.pub"
}
