resource "aws_eip" "jskim_eip_nat" {
  vpc = true
}


resource "aws_nat_gateway" "jskim_nat" {
  allocation_id = aws_eip.jskim_eip_nat.id
  subnet_id     = aws_subnet.jskim_pub[0].id
  tags = {
    "Name" = "${var.name}-nat"
  }
  depends_on = [
    aws_internet_gateway.jskim_igw
  ]
}


resource "aws_route_table" "jskim_natrt" {
  vpc_id = aws_vpc.jskim_vpc.id
  route {
    cidr_block = var.cidr_all
    gateway_id = aws_nat_gateway.jskim_nat.id
  }
  tags = {
    "Name" = "${var.name}-natrt"
  }
}


resource "aws_route_table_association" "jskim_natass" {
  count          = length(var.cidr_pri)
  subnet_id      = aws_subnet.jskim_pri[count.index].id
  route_table_id = aws_route_table.jskim_natrt.id
}
