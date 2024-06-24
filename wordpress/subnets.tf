# Public subnets for wordpress
resource "aws_subnet" "wordpress_public_subnets" {
  depends_on              = [aws_vpc.wordpress_vpc]
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags                    = { Name = "${var.availability_zones[count.index]}_wordpress_public_subnets" }
}

# Private Subnet for backend application
resource "aws_subnet" "wordpress_private_app_subnets" {
  depends_on        = [aws_vpc.wordpress_vpc]
  count             = length(var.private_app_subnet_cidrs)
  vpc_id            = aws_vpc.wordpress_vpc.id
  cidr_block        = element(var.private_app_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags              = { Name = "${var.availability_zones[count.index]}_wordpress_private_app_subnets" }
}

# Private Data Subnets for RDS
resource "aws_subnet" "wordpress_private_db_subnets" {
  depends_on        = [aws_vpc.wordpress_vpc]
  count             = length(var.private_db_subnet_cidrs)
  vpc_id            = aws_vpc.wordpress_vpc.id
  cidr_block        = element(var.private_db_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags              = { Name = "${var.availability_zones[count.index]}_wordpress_private_db_subnets" }
}

# Private subnet group for RDS DB
resource "aws_db_subnet_group" "rds_database_subnet_group" {
  name       = "wordpress_rds_db_subnet_group"
  subnet_ids = aws_subnet.wordpress_private_db_subnets[*].id
}

