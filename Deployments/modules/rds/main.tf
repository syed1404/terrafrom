resource "aws_db_instance" "rds_npd" {
  allocated_storage      = var.allocated_storage_v
  engine                 = var.engine_type
  engine_version         = var.engine_version_v
  instance_class         = var.rds_instance_type
  identifier             = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = var.parameter_group_name_v
  publicly_accessible    = var.publicly_accessible_v
  skip_final_snapshot    = var.skip_final_snapshot_v
  db_subnet_group_name   = var.db_subnet_group_name_v
  vpc_security_group_ids = [var.rds_sg]
 
  tags = {
    Name = var.db_name
  }
}
 
resource "aws_db_subnet_group" "db_subnet_npd" {
  name       = var.db_subnet_group_name_v
  subnet_ids = [var.private_subnet1, var.private_subnet2]
}