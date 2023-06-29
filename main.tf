data "aws_vpc" "existing_london_vpc" {
    id = "vpc-038e7ff157e871219"  # Replace with the desired VPC name
}

data "aws_subnet" "existing_subnet" {
    id = "subnet-06744f132ff4d687e"  # Replace with the desired subnet name
}

resource "aws_security_group" "my_security_group_2" {
  name        = "my-london-security-group-2"
  description = "My security group allowing all traffic from 2"
  vpc_id      = data.aws_vpc.existing_london_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
}


resource "aws_instance" "ansible_server" {
  ami           = "ami-07650ecb0de9bd731"
  instance_type = "t2.micro"
  key_name      = "luqman-london"
  subnet_id     = data.aws_subnet.existing_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.my_security_group_2.id]
  user_data     = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install pip -y
    sudo python3 -m pip install --user ansible
    EOF

  tags = {
    Name = "ansibleserver"
  }
}

resource "aws_instance" "web_server_1" {
  ami           = "ami-07650ecb0de9bd731"
  instance_type = "t2.micro"
  key_name      = "luqman-london"
  subnet_id     = data.aws_subnet.existing_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.my_security_group_2.id]

  tags = {
    Name = "webserver-1"
  }
}

resource "aws_instance" "web_server_2" {
  ami           = "ami-07650ecb0de9bd731"
  instance_type = "t2.micro"
  key_name      = "luqman-london"
  subnet_id     = data.aws_subnet.existing_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.my_security_group_2.id]

  tags = {
    Name = "webserver-2"
  }
}


