resource "aws_docdb_subnet_group" "default" {
  name       = "${var.env}-docdb-subnet_group"
  subnet_ids = var.subnet_ids

  tags = merge(
    local.common_tags,
    { Name = "${var.env}-docdb-subnet_group" }
  )
}

resource "aws_security_group" "docdb" {
  name        = "${var.env}-docdb-security_group"
  description = "${var.env}-docdb-security_group"
  vpc_id      = var.vpc_id

  ingress {
    description      = "MongoDB"
    from_port        = 27017
    to_port          = 27017
    protocol         = "tcp"
    cidr_blocks      = var.allow_cidr
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    { Name = "${var.env}-docdb-surity_group" }
  )
}

resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "${var.env}-docdb-cluster"
  engine                  = "docdb"
  master_username         = "foo"
  master_password         = "mustbeeightchars"
  skip_final_snapshot     = true
  db_subnet_group_name = aws_docdb_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.docdb.id]
  tags = merge(
    local.common_tags,
    { Name = "${var.env}-docdb-cluster" }
  )
}