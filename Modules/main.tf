resource "aws_vpc" "myapp-vpc" {
    cidr_blocks = var.vpc_cidr_blocks
    tags = {
        Name: "$(var.env-prefixid)-vpc"
    }
}

module "myapp-subnet" {
    source = "./modules/subnet"
    vpc_id = aws_vpc.myapp-vpc.id
    subnet_cidr_blocks = var.subnet_cidr_blocks
    env-prefixid = var.env-prefixid
    availability_zone = var.availability_zone
  
}

module "web-server" {
    source = "./modules/Webserver"
    vpc_id = aws_vpc.myapp-vpc.id
    subnet_id = module.myapp-subnet.subnet.id
    myip = var.myip
    env-prefixid = var.env-prefixid
    availability_zone = var.availability_zone
    public_key_location =var.public_key_location
    instancetype = var.instancetype
    image_name = var.image_name
  
}