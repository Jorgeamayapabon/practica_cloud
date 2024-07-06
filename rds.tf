resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.subred_publica1.id, aws_subnet.subred_publica2.id]  
  
  tags = {
    Name = "db_subnet_group"
  }
}

resource "aws_db_instance" "db_instance" {
  identifier           = "my-db-sql-instace"
  allocated_storage    = 10
  storage_type         = "gp2"
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  publicly_accessible  = true
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.instance_security_group.id]
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  tags = {
    Name = "db_instance"
  }
}
