provider "aws" {
  region  = "ap-south-1"
  profile = "AdminAccess-602151476946"
}


resource "aws_vpc" "Abhishek-VPC" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "Abhishek-SB" {
  vpc_id            = aws_vpc.Abhishek-VPC.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "Abhishek-IG" {
  vpc_id = aws_vpc.Abhishek-VPC.id
}
resource "aws_route_table" "Abhishek-RT" {
  vpc_id = aws_vpc.Abhishek-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Abhishek-IG.id
  }

  tags = {
    Name = "day-two-abhishek-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.Abhishek-SB.id
  route_table_id = aws_route_table.Abhishek-RT.id
}

resource "aws_security_group" Abhishek-SG" {
  name = "day-two-abhishek-sg"
  vpc_id      = aws_vpc.Abhishek-VPC.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "day-two-abhishek-sg"
  }
}
module "my_web_server" {
  source = "./modules/ec2_instance"

  instance_type=var.instance_type
  ami_id=var.web_server_ami
  subnet_id=aws_subnet.Abhishek-SB.id
  security_group_ids=[aws_security_group.Abhishek-SG.id]
  tags={
    Name="day-two-abhishek-ec2"
  }
}