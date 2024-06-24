# Internet gateway for wordpress
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.wordpress_vpc.id
  tags = {
    Name = "wordpress_internet_gateway"
  }
}