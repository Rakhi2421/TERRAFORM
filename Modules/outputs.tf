output "aws_ami_id" {
    value = module.web-server.image_id
  
}

output "ec2-public-ip" {
    value = module.web-server.instance.public_ip 
}