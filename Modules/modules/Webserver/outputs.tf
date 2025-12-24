output "instance" {
    value = aws_instance.myapp-server  
}

output "image_id" {
    value = data.aws_ami.latest-ami-linux-image
  
}