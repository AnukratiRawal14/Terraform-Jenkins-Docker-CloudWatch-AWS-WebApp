variable "subnet_id" {
  description = "Subnet ID where Jenkins will be launched"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to launch Jenkins EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID for Jenkins EC2"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile to attach to Jenkins EC2"
  type        = string
}

variable "key_name" {
  description = "Key pair name (optional for testing)"
  type        = string
}
