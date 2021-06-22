resource "aws_vpc" "GO-VPC" {
  cidr_block = "10.0.0.0/26"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "GO-VPC"
  }
}

resource "aws_internet_gateway" "GO-IGW" {
  vpc_id = aws_vpc.GO-VPC.id
  tags = {
    Name = "GO-IGW"
  }
}

resource "aws_subnet" "GO-Public-Subnet" {
  cidr_block = "10.0.0.0/28"
  vpc_id = aws_vpc.GO-VPC.id
  tags = {
    Name = "GO-Public-Subnet"
  }
}
//
//resource "aws_subnet" "GO-Private-Subnet" {
//  cidr_block = "10.0.0.16/28"
//  vpc_id = aws_vpc.GO-VPC.id
//  tags = {
//    Name = "GO-Private-Subnet"
//  }
//}

resource "aws_route_table" "GO-Public-RT" {
  vpc_id = aws_vpc.GO-VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.GO-IGW.id
  }
  tags = {
    Name = "GO-Public-RT"
  }
}

resource "aws_route_table_association" "GO-Public-RTA" {
  route_table_id = aws_route_table.GO-Public-RT.id
  subnet_id = aws_subnet.GO-Public-Subnet.id
}

resource "aws_eip" "GO-EIP" {
  vpc = true
  tags = {
    Name = "GO-EIP"
  }
}
//
//resource "aws_nat_gateway" "GO-NAT-GW" {
//  allocation_id = aws_eip.GO-EIP.id
//  subnet_id = aws_subnet.GO-Public-Subnet.id
//  tags = {
//    Name = "GO-NAT-GW"
//  }
//}
//
//resource "aws_route_table" "GO-Private-RT" {
//  vpc_id = aws_vpc.GO-VPC.id
//  route {
//    cidr_block = "0.0.0.0/0"
//    nat_gateway_id = aws_nat_gateway.GO-NAT-GW.id
//  }
//  tags = {
//    Name = "GO-Private-RT"
//  }
//}
//resource "aws_route_table_association" "GO-Private-RTA" {
//  route_table_id = aws_route_table.GO-Private-RT.id
//  subnet_id = aws_subnet.GO-Private-Subnet.id
//}

resource "aws_security_group" "GO-Public-SG" {
  name = "GO-Public-SG"
  vpc_id = aws_vpc.GO-VPC.id
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [var.myIp]
  }
  ingress {
    from_port = 5000
    protocol = "tcp"
    to_port = 5000
    cidr_blocks = [var.myIp]
  }
  ingress {
    from_port = 5000
    protocol = "tcp"
    to_port = 5000
    cidr_blocks = [var.vpc_cider]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "GO-Public-SG"
  }
}

resource "aws_instance" "GO-Public-EC2" {
  ami = var.ami-ubuntu-18-4
  instance_type = var.instance_type
  key_name = "EC2"
  user_data = file("docker-install.sh")

  security_groups = [aws_security_group.GO-Public-SG.id]
  subnet_id = aws_subnet.GO-Public-Subnet.id
  associate_public_ip_address = true

  tags = {
    Name = "GO-Public-EC2"
  }
//  connection {
//    type = "ssh"
//    host = aws_instance.GO-Public-EC2.public_ip
//    user = "ubuntu"
//    password = ""
//    private_key = file("EC2.pem")
//  }
//  provisioner "remote-exec" {
//    inline = [
//      "sudo docker run -it --rm -p 5000:80 --name test edc8e69227eb"
//    ]
//  }
}

//resource "aws_security_group" "GO-Private-SG" {
//  name = "GO-Private-SG"
//  vpc_id = aws_vpc.GO-VPC.id
//  ingress {
//    from_port = 22
//    protocol = "tcp"
//    to_port = 22
//    cidr_blocks = ["10.0.0.0/26"]
//  }
//  ingress {
//    from_port = -1
//    protocol = "icmp"
//    to_port = -1
//    cidr_blocks = ["10.0.0.0/26"]
//  }
//  ingress {
//    from_port = 5000
//    protocol = "tcp"
//    to_port = 5000
//    cidr_blocks = [var.myIp]
//  }
//  egress {
//    from_port = 0
//    protocol = "-1"
//    to_port = 0
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//  tags = {
//    Name = "GO-Private-SG"
//  }
//}

//resource "aws_instance" "GO-Private-EC2" {
//  ami = var.ami-ubuntu-18-4
//  instance_type = var.instance_type
//  key_name = "EC2"
//  security_groups = [aws_security_group.GO-Private-SG.id]
//  subnet_id = aws_subnet.GO-Private-Subnet.id
//  associate_public_ip_address = false
//  tags = {
//    Name = "GO-Private-EC2"
//  }
//}

//resource "aws_security_group" "GO-Public-SG-W" {
//  vpc_id = aws_vpc.GO-VPC.id
//  name = "GO-Public-SG-W"
//  ingress {
//    from_port = 3389
//    protocol = "tcp"
//    to_port = 3389
//    cidr_blocks = [var.myIp]
//  }
//  egress {
//    from_port = 0
//    protocol = "-1"
//    to_port = 0
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//}

//resource "aws_instance" "GO-Public-EC2-W" {
//  ami = var.w-base-image
//  instance_type = var.instance_type
//  key_name = "EC2"
//  subnet_id = aws_subnet.GO-Public-Subnet.id
//  associate_public_ip_address = true
//  security_groups = [aws_security_group.GO-Public-SG-W.id]
//  tags = {
//    Name = "GO-Public-EC2-W"
//  }
//}

//resource "aws_security_group" "GO-Private-SG-W" {
//  name = "GO-Private-SG-W"
//  vpc_id = aws_vpc.GO-VPC.id
//  ingress {
//    from_port = -1
//    protocol = "icmp"
//    to_port = -1
//    cidr_blocks = [var.vpc_cider]
//  }
//  ingress {
//    from_port = 3389
//    protocol = "tcp"
//    to_port = 3389
//    cidr_blocks = [var.vpc_cider]
//  }
//  egress {
//    from_port = 0
//    protocol = "-1"
//    to_port = 0
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//}

//resource "aws_instance" "GO-Private-EC2-W" {
//  ami = var.w-base-image
//  instance_type = var.instance_type
//  key_name = "EC2"
//  security_groups = [aws_security_group.GO-Private-SG-W.id]
//  subnet_id = aws_subnet.GO-Private-Subnet.id
//  associate_public_ip_address = false
//  tags = {
//    Name = "GO-Private-EC2-W"
//  }
//}


output "Public_IP" {
  value = aws_instance.GO-Public-EC2.public_ip
}
//output "Windows_Public_IP" {
//  value = aws_instance.GO-Public-EC2-W.public_ip
//}
//
//output "Jump-x-Private_IP"{
//  value = aws_instance.GO-Public-EC2.private_ip
//}
//output "Private_IP" {
//  value = aws_instance.GO-Private-EC2.private_ip
//}
//output "Win_Private_Internal_IP" {
//  value = aws_instance.GO-Private-EC2-W.private_ip
//}
//
//output "Win_Jump_Internal_IP" {
//  value = aws_instance.GO-Public-EC2-W.private_ip
//}