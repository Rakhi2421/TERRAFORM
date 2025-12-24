resource "aws_subnet" "myapp-subnet1d" {
    vpc_id = var.vpc_id
    availability_zone = var.availability_zone
    cidr_blocks = var.subnet_cidr_blocks
    tags = {
        Name: "$(var.env-prefixid)-subnet1"
    } 
}
resource "aws_route_table" "myapp-route1" {
    vpc_id = var.vpc_id

    route {
        cidr_blocks = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myapp-igw.id      
    }
    tags = {
        Name: "$(var.env-prefixid)-rtb1"
    } 
}

resource "aws_internet_gateway" "myapp-igw" {
    vpc_id = var.vpc_id
    tags = {
        Name: "$(var.env-prefixid)-igw1"
    }  
}

# subnet association with route table

resource "aws_route_table_association" "subnet-association-1" {
    subnet_id = aws_subnet.myapp-subnet1d.id
    route_table_id = aws_route_table.myapp-route1.id
  
}

# Using default route table

resource "aws_default_route_table" "default-rtb" {
    default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
    
    route {
        cidr_blocks = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myapp-igw.id      
    }
    tags = {
        Name: "$(var.env-prefixid)-mainrtb"
    } 
}
