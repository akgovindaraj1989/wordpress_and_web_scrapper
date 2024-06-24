# outputs.tf

output "vpc" {
  value = aws_vpc.wordpress_vpc.id
}

output "public_subnets" {
  value = aws_subnet.wordpress_public_subnets[*].id
}

output "private_app_subnets" {
  value = aws_subnet.wordpress_private_app_subnets[*].id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.rds_database_subnet_group.name
}

# Get the most up-to-date version of Amazon linux AMI
data "aws_ami" "latestami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

output "Website_Address" {
  value = aws_lb.wordpress_alb.dns_name
}