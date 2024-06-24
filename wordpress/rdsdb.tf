# RDS DB Instance
resource "aws_db_instance" "default" {
  allocated_storage      = 20
  max_allocated_storage  = 100
  db_name                = "wordpress_db"
  engine                 = "mysql"
  engine_version         = "8.0.33"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = aws_secretsmanager_secret_version.db_pass.secret_string
  storage_type           = "gp2"
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  identifier             = "wordpress-db"
  multi_az               = true
  db_subnet_group_name   = aws_db_subnet_group.rds_database_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_db_sg.id]
}