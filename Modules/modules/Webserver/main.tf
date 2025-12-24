
# Creating a new security Group

resource "aws_security_group" "myapp-sg" {
    name = "myapp-sg"
    vpc_id = var.vpc_id

    ingress = {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = var.myip
    }
    ingress = {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }
    egress = {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = "0.0.0.0/0"
        prefix_list_ids = []
    }
    tags = {
      Name: "${var.env-prefixid}-sg"
    }
  
}


# Using default security group

resource "aws_default_security_group" "default-sg" {
    vpc_id = var.vpc_id 

    ingress = {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = var.myip
    }
    ingress = {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }
    egress = {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = "0.0.0.0/0"
        prefix_list_ids = []
    }
    tags = {
      Name: "${var.env-prefixid}-default-sg"
    }
}

# Fetching the latest ami image from aws

data "aws_ami" "latest-ami-linux-image" {
    most_recent = true
    owners = ["amazon"]
    filter {
      name = "name"
      values = [var.image_name]
    }
    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
}



# Creating an ec2-instance

resource "aws_instance" "myapp-server" {
    ami = data.aws_ami.latest-ami-linux-image
    instance_type = var.instancetype

    subnet_id = var.subnet_id
    vpc_security_group_ids = [aws_default_security_group.default-sg.id]
    availability_zone = var.availability_zone

    associate_public_ip_address = true
    # if key pair is already created from aws and configured it on your local- use this one
    key_name = "server-key-pair"
    # if key pair is created using the resource use this
    key_name = aws_key_pair.ssh-key.key_name

    # setup an application at the time of creating a server. once server is created, we can't use this one. 
    # Using scripting directly in main file
    user_data = <<EOF
                    #!/bin/bash
                    sudo yum update -y && sudo yum install docker -y
                    sudo systemctl docker
                    sudo usermod -aG docker ec2-user
                    docker run -p 8089:80 nginx
                EOF  
     # define entry script file instead of hardcore here
     user_data =  file("entry-script.sh")              
    
    tags = {
      Name: "${var.env-prefixid}-server"
    }
  
}

# Creating a key pair

resource "aws_key_pair" "ssh-key" {
    key_name = "server-key"
    public_key = file(var.public_key_location) # to specify the public key location.
    
}
