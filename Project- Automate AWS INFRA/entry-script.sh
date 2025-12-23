 #!/bin/bash
sudo yum update -y && sudo yum install docker -y
sudo systemctl docker
sudo usermod -aG docker ec2-user
docker run -p 8089:80 nginx
