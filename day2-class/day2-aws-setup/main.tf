resource "aws_vpc" "abhishek-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "minfy-abhishek-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.abhishek-vpc.id

  tags = {
    Name = "day-two-abhishek-gw"
  }
}

resource "aws_subnet" "abhishek-sb" {
  vpc_id                  = aws_vpc.abhishek-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "day-two-abhishek-sb"
  }
}


resource "aws_route_table" "abhishek-rt" {
  vpc_id = aws_vpc.abhishek-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "day-two-abhishek-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.abhishek-sb.id
  route_table_id = aws_route_table.abhishek-rt.id
}

resource "aws_security_group" "day-two-sg" {
  name = "day-two-abhishek-sg"
  description = "Allow http and ssh inbounds"
  vpc_id      = aws_vpc.abhishek-vpc.id

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
    Name = "abhishek-ec2-sg"
  }
}

resource "aws_instance" "day-two-abhishek" {
  ami                    = "ami-0b09627181c8d5778"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.abhishek-sb.id
  vpc_security_group_ids = [aws_security_group.day-two-sg.id]
  associate_public_ip_address = true
  user_data = <<-EOF
    #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
            EOF
 
  tags = {
    Name = "day-two-abhishek"
  }
}

