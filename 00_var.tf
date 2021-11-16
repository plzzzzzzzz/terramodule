variable "key" {
  type    = string
  default = "jskim2-key"
}


variable "region" {
  type    = string
  default = "ap-northeast-2"
}


variable "cidr_vpc" {
  type    = string
  default = "10.0.0.0/16"
}


variable "name" {
  type    = string
  default = "jskim"
}


variable "az" {
  type    = list(string)
  default = ["a", "c"]
}


variable "cidr_pub" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}


variable "cidr_pri" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}


variable "cidr_pridb" {
  type    = list(string)
  default = ["10.0.5.0/24", "10.0.6.0/24"]
}


variable "cidr_all" {
  type    = string
  default = "0.0.0.0/0"
}


variable "cidr_v6" {
  type    = string
  default = "::/0"
}


variable "port_http" {
  type = number
  default = 80
}


variable "instance_default" {
  type    = string
  default = "t2.micro"
}


variable "ins_pri_ip" {
  type = string
  default = "10.0.1.11"
}


variable "name_db" {
  type = string
  default = "test"
}


variable "username_db" {
  type = string
  default = "admin"
}


variable "password_db" {
  type = string
  default = "It12345!"
}