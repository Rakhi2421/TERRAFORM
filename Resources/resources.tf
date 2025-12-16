resource "aws_vpc" "learning-vpc" {
    cidr_block = "10.0.0.0/16"  
}

resource "aws_subnet" "learning-subnet" {
    vpc_id = aws_vpc.learning-vpc.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "eu-west-3a"  
}

# Using tags- Tags are key value pairs in aws.
# syntax : mykey: myvalue 

resource "aws_vpc" "learning-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name: "development"
        vpc_env: "dev"
    }
}
resource "aws_subnet" "learning-subnet" {
    vpc_id = aws_vpc.learning-vpc.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "eu-west-3a" 
    tags = {
        Name: "learning-subnet-1"
    } 
}

