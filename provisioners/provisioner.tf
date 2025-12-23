resource "aws_instance" "myapp-server" {
    ami = data.aws_ami.latest-ami-linux-image
    instance_type = var.instancetype

    subnet_id = aws_subnet.myapp-subnet1d.id
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
# Provisioners
    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = file(var.private_key_location)
    }
 # file provisioner - It's specifically made for to copy a files or directories from local to newly created resource.
    provisioner "file" {
        source = "entry-script.sh"
        destination = "/home/ec2-user/entry-script-on-ec2 .sh"

    }
    provisioner "remote-exec" {
        script = file("entry-script-on-ec2.sh")
     }

     provisioner "remote-exec" {
        inline = [ 
            "export ENV=dev",
            "mkdir newdir"
         ]
     }
     # Local-exec Provisioner - it invokes a local executable after a resource is created.
    provisioner "local-exec" {
        command = "echo ${self.public_ip} > output.txt"
    }
    
    tags = {
      Name: "${var.env-prefixid}-server"
    }