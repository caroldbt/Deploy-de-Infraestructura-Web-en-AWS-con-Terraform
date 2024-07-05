output "public_ip" {
  value = module.ec2.public_ip
}

output "sns_topic_arn" {
  value = module.sns.sns_topic_arn
}
