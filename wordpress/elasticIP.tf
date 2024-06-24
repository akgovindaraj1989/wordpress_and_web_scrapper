# Elastic IP creation for nat gateway
resource "aws_eip" "elastic_ip" {
  count  = 2
  domain = "vpc"
  tags = {
    Name = "wordpress_nat_gateway_elastic_ip"
  }
}