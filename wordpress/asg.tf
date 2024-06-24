resource "aws_autoscaling_group" "wordpress-asg" {
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.app_server_ec2.name
  vpc_zone_identifier  = [aws_subnet.wordpress_private_app_subnets[0].id,aws_subnet.wordpress_private_app_subnets[1].id,]
  name                 = "Wordpress_asg"
}

resource "aws_lb_target_group" "private_application_tg" {
  name     = "EC2--Target-Group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.wordpress_vpc.id
}

resource "aws_autoscaling_attachment" "wordpress" {
  autoscaling_group_name = aws_autoscaling_group.wordpress-asg.id
  lb_target_group_arn    = aws_lb_target_group.private_application_tg.arn
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.wordpress_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_application_tg.arn
  }
}