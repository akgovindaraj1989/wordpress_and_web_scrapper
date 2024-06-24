# Nat gateway for app and db server to have internet access
resource "aws_nat_gateway" "wordpress_nat_gateway" {
  count             = 2
  depends_on        = [aws_eip.elastic_ip, aws_subnet.wordpress_public_subnets[0], aws_subnet.wordpress_public_subnets[1]]
  allocation_id     = aws_eip.elastic_ip[count.index].id
  subnet_id         = aws_subnet.wordpress_public_subnets[count.index].id
  connectivity_type = "public"
  tags = {
    Name = "${var.availability_zones[count.index]}_wordpress_nat_gateway"
  }
}