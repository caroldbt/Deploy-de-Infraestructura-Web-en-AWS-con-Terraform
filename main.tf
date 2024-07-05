provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source       = "./vpc"
  vpc_cidr_block = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
}

module "security_group" {
  source = "./security_group"
  vpc_id = module.vpc.vpc_id
}

module "sns" {
  source = "./sns"
  subscription_email = var.subscription_email
}

module "ec2" {
  source       = "./ec2"
  subnet_id    = module.vpc.subnet_id
  ami          = var.ami
  instance_type = var.instance_type
  key_name     = var.key_name
  security_group_id = module.security_group.security_group_id
  sns_topic_arn = module.sns.sns_topic_arn
}

