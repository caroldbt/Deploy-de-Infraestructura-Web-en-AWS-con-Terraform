
output "vpc_id" {
  value = aws_vpc.tf.id
}

output "subnet_id" {
  value = aws_subnet.selected.id
}
