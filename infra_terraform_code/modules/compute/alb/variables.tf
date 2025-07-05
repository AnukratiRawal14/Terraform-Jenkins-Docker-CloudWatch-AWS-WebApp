variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = list(string)
}

variable "instance_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}