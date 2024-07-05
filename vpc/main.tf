resource "aws_vpc" "tf" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "selected" {
  vpc_id                  = aws_vpc.tf.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "selected" {
  vpc_id = aws_vpc.tf.id
}

resource "aws_route_table" "selected" {
  vpc_id = aws_vpc.tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.selected.id
  }
}

resource "aws_route_table_association" "selected" {
  subnet_id      = aws_subnet.selected.id
  route_table_id = aws_route_table.selected.id
}
