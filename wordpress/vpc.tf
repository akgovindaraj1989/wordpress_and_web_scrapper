# VPC for wordpress
resource "aws_vpc" "wordpress_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "wordpress_vpc"
    } 
}