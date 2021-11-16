resource "aws_security_group" "jskim_sg" {
  name        = "Allow Basic"
  description = "Allow HTTP,SSH,SQL,ICMP"
  vpc_id      = aws_vpc.jskim_vpc.id

  ingress = [
    {
      description      = "Allow HTTP"
      from_port        = var.port_http
      to_port          = var.port_http
      protocol         = "tcp"
      cidr_blocks      = [var.cidr_all]
      ipv6_cidr_blocks = [var.cidr_v6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = "Allow SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = [var.cidr_all]
      ipv6_cidr_blocks = [var.cidr_v6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = "Allow SQL"
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = [var.cidr_all]
      ipv6_cidr_blocks = [var.cidr_v6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = "Allow ICMP"
      from_port        = 0
      to_port          = 0
      protocol         = "icmp"
      cidr_blocks      = [var.cidr_all]
      ipv6_cidr_blocks = [var.cidr_v6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  egress = [
    {
      description      = "ALL"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = [var.cidr_all]
      ipv6_cidr_blocks = [var.cidr_v6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]
  tags = {
    "Name" = "${var.name}-sg"
  }
}


resource "aws_instance" "jskim_weba" {
  ami                    = "ami-04e8dfc09b22389ad"
  instance_type          = var.instance_default
  key_name               = var.key
  availability_zone      = "${var.region}${var.az[0]}"
  private_ip             = var.ins_pri_ip
  subnet_id              = aws_subnet.jskim_pub[0].id
  vpc_security_group_ids = [aws_security_group.jskim_sg.id]
  user_data              = file("./install.sh")
}

resource "aws_eip" "jskim_weba_eip" {
  vpc                       = true
  instance                  = aws_instance.jskim_weba.id
  associate_with_private_ip = var.ins_pri_ip
  depends_on = [
    aws_internet_gateway.jskim_igw
  ]
}
