
resource "aws_lb" "wordpress_alb" {
  name               = "LoadBalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ALB_Security_Group.id]
  subnets            = [for subnet in aws_subnet.wordpress_public_subnets : subnet.id]
}