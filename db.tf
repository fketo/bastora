

resource "aws_db_instance" "ora-test" {
  identifier = var.db_identifier
  engine               =var.db_engine
  engine_version       = var.db_engine_version
  storage_type       = var.db_storage_type
  multi_az = var.db_multi_az
  instance_class       = var.db_instance_class
  license_model        = var.db_license_model
  allocated_storage    = var.db_allocated_storage
  max_allocated_storage = var.db_max_allocated_storage
  username               = var.db_username
  password=var.db_password
  db_subnet_group_name = aws_db_subnet_group.sng-ora.name
  skip_final_snapshot = true
  vpc_security_group_ids =  [aws_security_group.sg_private.id]
}

  #subnet_ids             = "${element(aws_subnet.subnet-priv01.*.id,count.index)}"
  #vpc_security_group_ids =  [aws_security_group.sg_private.id]

/*

  name                   = "COMPLETEORACLE"
  
  create_random_password = true
  random_password_length = 12
  port                   = 1521

  multi_az               = false
  subnet_ids             = "${element(aws_subnet.subnet-priv01.*.id,count.index)}"
  vpc_security_group_ids =  [aws_security_group.sg_private.id]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["alert", "audit"]

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true

  # See here for support character sets https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.OracleCharacterSets.html
  character_set_name = "AL32UTF8"

  tags = local.tags
*/