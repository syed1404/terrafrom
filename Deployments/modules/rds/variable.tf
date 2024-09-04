variable "allocated_storage_v" {
  type    = number
  default = 10
}
variable "engine_type" {
  type    = string
  default = "mysql"
}
variable "engine_version_v" {
  type    = string
  default = "8.0.35"
}
variable "rds_instance_type" {
  type    = string
  default = "db.t3.micro"
}
variable "db_name" {
  type    = string
  default = "rds-test"
}
variable "db_username" {
  type    = string
  default = "dbuser"
}
variable "db_password" {
  type    = string
  default = "Password@123"
}
variable "parameter_group_name_v" {
  type    = string
  default = "default.mysql8.0"
}
variable "publicly_accessible_v" {
  type    = bool
  default = false
}
variable "skip_final_snapshot_v" {
  type    = bool
  default = true
}
variable "db_subnet_group_name_v" {
  type    = string
  default = "db_subnet_grp"
}
variable "private_subnet1" {
  type = string
}
variable "private_subnet2" {
  type = string
}
variable "rds_sg" {
  type = string
}