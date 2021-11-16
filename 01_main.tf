# key pair 설정
resource "aws_key_pair" "jskim_key" {
  key_name   = var.key
  public_key = file("../../.ssh/jskim-key.pub")
}


# region 설정
provider "aws" {
  region = var.region
}


# vpc 설정
resource "aws_vpc" "jskim_vpc" {
  cidr_block = var.cidr_vpc
  tags = {
    "Name" = "${var.name}-vpc"
  }
}


# Public Subnet 설정
resource "aws_subnet" "jskim_pub" {
  count             = length(var.cidr_pub)
  vpc_id            = aws_vpc.jskim_vpc.id
  cidr_block        = var.cidr_pub[count.index]
  availability_zone = "${var.region}${var.az[count.index]}"
  tags = {
    "Name" = "${var.name}-pub${var.az[count.index]}"
  }
}


# Private Subnet 설정
resource "aws_subnet" "jskim_pri" {
  count             = length(var.cidr_pri)
  vpc_id            = aws_vpc.jskim_vpc.id
  cidr_block        = var.cidr_pri[count.index]
  availability_zone = "${var.region}${var.az[count.index]}"
  tags = {
    "Name" = "${var.name}-pub${var.az[count.index]}"
  }
}


# Private DB Subnet 설정
resource "aws_subnet" "jskim_pridb" {
  count             = length(var.cidr_pridb)
  vpc_id            = aws_vpc.jskim_vpc.id
  cidr_block        = var.cidr_pridb[count.index]
  availability_zone = "${var.region}${var.az[count.index]}"
  tags = {
    "Name" = "${var.name}-pridb${var.az[count.index]}"
  }
}
