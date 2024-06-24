# Public route table for internet gateway
resource "aws_route_table" "wordpress_public_subnet_routeTable" {
  depends_on = [aws_internet_gateway.internet_gateway]
  vpc_id     = aws_vpc.wordpress_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "wordpress_public_subnet_routeTable"
  }
}

# Private route table for app server subnet 1
resource "aws_route_table" "app_subnet_1_route_table" {
  depends_on = [aws_nat_gateway.wordpress_nat_gateway[0]]
  vpc_id     = aws_vpc.wordpress_vpc.id
  tags = {
    Name = "${var.availability_zones[0]}_wordpress_app_subnet_1_route_table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.wordpress_nat_gateway[0].id
  }
}

# Private route table for app server subnet 2
resource "aws_route_table" "app_subnet_2_route_table" {
  depends_on = [aws_nat_gateway.wordpress_nat_gateway[1]]

  vpc_id = aws_vpc.wordpress_vpc.id
  tags = {
    Name = "${var.availability_zones[1]}_wordpress_app_subnet_2_route_table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.wordpress_nat_gateway[1].id
  }
}

# wordpress_public_subnet_routeTable association
resource "aws_route_table_association" "wordpress_public_subnet_association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.wordpress_public_subnets[*].id, count.index)
  route_table_id = aws_route_table.wordpress_public_subnet_routeTable.id
}
# Association for private subnet 1 (aza)
resource "aws_route_table_association" "app_subnet_1_association" {
  subnet_id      = aws_subnet.wordpress_private_app_subnets[0].id
  route_table_id = aws_route_table.app_subnet_1_route_table.id
}
# Association for private subnet 2 (azb)
resource "aws_route_table_association" "app_subnet_2_association" {
  subnet_id      = aws_subnet.wordpress_private_app_subnets[1].id
  route_table_id = aws_route_table.app_subnet_2_route_table.id
}