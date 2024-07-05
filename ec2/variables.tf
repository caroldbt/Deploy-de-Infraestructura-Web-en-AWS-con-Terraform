variable "subnet_id" {
  description = "Subnet ID."
  type        = string
}

variable "ami" {
  description = "AWS AMI."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
}

variable "key_name" {
  description = "AWS key name."
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID."
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS Topic ARN."
  type        = string
}
