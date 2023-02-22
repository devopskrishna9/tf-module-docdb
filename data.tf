data "aws_ssm_parameter" "DB_ADMIN_USER" {
  name = "${var.env}.docdb.DB_ADMIN_USER"
}

data "aws_ssm_parameter" "DB_ADMIN_PASS" {
  name = "${var.env}.docdb.DB_ADMIN_PASS"
}

data "aws_kms_key" "by_id" {
  key_id = "d3bd81d9-9679-44f3-8d22-98fbf65735dc"
}