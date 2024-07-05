variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "AWS VPC CIDR block."
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "AWS subnet CIDR block."
  default     = "10.0.1.0/24"
}

variable "key_name" {
  description = "AWS key_name."
  default     = "vockey"
}

variable "ami" {
  description = "AWS AMI."
  default     = "ami-08a0d1e16fc3f61ea"
}

variable "instance_type" {
  description = "EC2 instance type."
  default     = "t2.micro"
}

variable "subscription_email" {
  description = "Email address to subscribe to the SNS topic."
  type        = string
  default     = "carol.burgos@tajamar365.com"
}
