# Internet Gateway 생성
resource "aws_internet_gateway" "jskim_igw" {
  vpc_id = aws_vpc.jskim_vpc.id

  tags = {
    "Name" = "${var.name}-igw"
  }
}


resource "aws_route_table" "jskim_rt" {
  vpc_id = aws_vpc.jskim_vpc.id
  route {
    cidr_block = var.cidr_all
    gateway_id = aws_internet_gateway.jskim_igw.id
  }
  tags = {
    "Name" = "${var.name}-rt"
  }
}


resource "aws_route_table_association" "jskim_rtass" {
  count          = length(var.cidr_pub)
  subnet_id      = aws_subnet.jskim_pub[count.index].id
  route_table_id = aws_route_table.jskim_rt.id
}
