# load balancer security group
resource "aws_security_group" "ALB_Security_Group" {
  name = "Load-Balancer-Security_Group"
  tags = {
    Name = "Load-Balancer-Security_Group"
  }
  vpc_id = aws_vpc.wordpress_vpc.id
}

# EC2/WordPress App Server Security Group
resource "aws_security_group" "wordpress_app_server_sg" {
  name = "EC2-SG"
  tags = {
    Name = "EC2-SG"
  }
  vpc_id = aws_vpc.wordpress_vpc.id
}

# Ingress rule for load balancer security group to anywhere world
resource "aws_security_group_rule" "alb_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ALB_Security_Group.id
}

# Egress rule for load balancer security group to app server ec2 instance sg
resource "aws_security_group_rule" "alb_egress" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ALB_Security_Group.id
  source_security_group_id = aws_security_group.wordpress_app_server_sg.id
}

# Ingress rule for app server security group from alb security group
resource "aws_security_group_rule" "app_server_ingress" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.wordpress_app_server_sg.id
  source_security_group_id = aws_security_group.ALB_Security_Group.id
}

# Egess rule for app server security group to RDS db security group
resource "aws_security_group_rule" "app_server_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.wordpress_app_server_sg.id
}

# RDS/Database Security Group
resource "aws_security_group" "rds_db_sg" {
  name = "rds_db_sg"
  tags = {
    Name = "rds_db_sg"
  }
  vpc_id      = aws_vpc.wordpress_vpc.id
}

# Ingress rule for security group rds db from app server ec2 security group
resource "aws_security_group_rule" "rds_db_ingress" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_db_sg.id
  source_security_group_id = aws_security_group.wordpress_app_server_sg.id
}