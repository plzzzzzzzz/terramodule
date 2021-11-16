resource "aws_db_instance" "jskim_rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.${var.instance_default}"
  name                   = var.name_db
  identifier             = var.name_db
  username               = var.username_db
  password               = var.password_db
  parameter_group_name   = "default.mysql8.0"
  availability_zone      = "${var.region}${var.az[0]}"
  db_subnet_group_name   = aws_db_subnet_group.jskim_dbsb.id
  vpc_security_group_ids = [aws_security_group.jskim_sg.id]
  skip_final_snapshot    = true
  tags = {
    "Name" = "${var.name}-rds"
  }
}

resource "aws_db_subnet_group" "jskim_dbsb" {
  name       = "${var.name}-dbsb-group"
  subnet_ids = [aws_subnet.jskim_pridb[0].id, aws_subnet.jskim_pridb[1].id]
  tags = {
    "Name" = "${var.name}-dbsb-gp"
  }
}
