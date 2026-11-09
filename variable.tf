
variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "deployer-key"
}

variable "public_key_path" {
  description = "Path of public SSH key"
  type        = string
  default     = "ec2-key.pub"
}

variable "vpc_name" {
  description = "Default VPC name tag"
  type        = string
  default     = "Default VPC"
}

variable "sg_name" {
  description = "Security group name"
  type        = string
  default     = "automate_sg"
}

variable "sg_description" {
  description = "Security group description"
  type        = string
  default     = "Create TF security group for EC2 instance"
}

variable "ssh_port" {
  description = "SSH port number"
  type        = number
  default     = 22
}

variable "allowed_cidr" {
  description = "Allowed SSH source CIDR"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ami_id" {
  description = "EC2 AMI ID"
  type        = string
  default     = "ami-0fdcaf433b661372d"
}

variable "instances" {
  description = "Map of EC2 instances to create (key = instance Name tag, value = instance type)"
  type        = map(string)
  default = {
    web = "t2.micro"
    app = "t2.small"
  }
}

variable "volume_encrypted" {
  description = "Enable root volume encryption"
  type        = bool
  default     = true
}

variable "volume_type" {
  description = "EBS volume type"
  type        = string
  default     = "gp3"
}

variable "volume_throughput" {
  description = "EBS throughput"
  type        = number
  default     = 200
}

variable "volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 8
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
  default     = "Terraform-EC2"
}

variable "root_volume_name" {
  description = "Root EBS volume name"
  type        = string
  default     = "my-root-block"
}
