provider "aws" {
  region = "us-east-1"  
}

# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"  
  map_public_ip_on_launch = true
}

# Create private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"  
}

# Create security group
resource "aws_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "My Security Group"
  vpc_id      = aws_vpc.my_vpc.id 

  # Inbound rule for SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule for all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 instance in public subnet
resource "aws_instance" "my_instance" {
  ami           = "ami-08a52ddb321b32a8c"  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
    delete_on_termination = true
  }

  tags = {
    purpose = "Assignment"
  }

  vpc_security_group_ids = [aws_security_group.my_security_group.id]
}
