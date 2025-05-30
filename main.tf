provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "glsid_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "GLSID-VPC"
  }
}

resource "aws_internet_gateway" "glsid_igw" {
  vpc_id = aws_vpc.glsid_vpc.id
  tags = {
    Name = "GLSID-IGW"
  }
}

resource "aws_subnet" "glsid_subnet" {
  vpc_id            = aws_vpc.glsid_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "GLSID-Subnet"
  }
}

resource "aws_route_table" "glsid_rt" {
  vpc_id = aws_vpc.glsid_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.glsid_igw.id
  }
}

resource "aws_route_table_association" "glsid_rta" {
  subnet_id      = aws_subnet.glsid_subnet.id
  route_table_id = aws_route_table.glsid_rt.id
}

resource "aws_security_group" "glsid_sg" {
  name        = "glsid-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.glsid_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "glsid_ec2" {
  ami                    = "ami-0c7217cdde317cfec" # Amazon Linux 2 AMI (us-east-1)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.glsid_sg.id]
  subnet_id              = aws_subnet.glsid_subnet.id
  key_name               = "kawkawkey" # Replace with your key pair name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              # Update package lists
              sudo apt-get update -y
              # Install Docker
              sudo apt-get install -y docker.io
              # Start Docker and enable it to run on boot
              sudo systemctl start docker
              sudo systemctl enable docker
              # Add the ubuntu user to the docker group
              sudo usermod -aG docker ubuntu
              # Pull and run the Dockerized app
              sudo docker run -d -p 3000:3000 <your-username>/glsid-app:1.0
              EOF

  tags = {
    Name = "GLSID-EC2"
  }
}


