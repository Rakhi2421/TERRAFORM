provider "aws" {
    region = "eu-west-3"
    access_key = "your aws access key"
    secret_key = "your secret key"  
}

variable "subnet_cidr_block" {
    description = "subnet cidr-block"
}

variable "vpc_cidr_block" {
    description = "vpc cidr block"  
}

resource "aws_vpc" "learning-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name: "development"
        vpc_env: "dev"
    }
}
resource "aws_subnet" "learning-subnet" {
    vpc_id = aws_vpc.learning-vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = "eu-west-3a" 
    tags = {
        Name: "learning-subnet-1"
    } 
}

# Replicate same infrastructure for different environment.

variable "environment" {
  description = "development"
}

resource "aws_vpc" "learning-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name: var.environment
        vpc_env: "dev"
    }
}

# default values - if we didn't mentioned the value for a variable in terraform.tfvars or in command line then it goes with the mentioned default value.

variable "subnet_cidr_block" {
    description = "subnet cidr-block"
    default = "10.0.45.0/24"
}

# Type Constraints in Variables using string
variable "cidr_block" {
    description = "cidr-block for vpc and subnet"
    default = "10.0.45.0/24"
    type = list(string)
}

resource "aws_vpc" "learning-vpc" {
    cidr_block = var.cidr_block[0]
    tags = {
        Name: "development"
        vpc_env: "dev"
    }
}
resource "aws_subnet" "learning-subnet" {
    vpc_id = aws_vpc.learning-vpc.id
    cidr_block = var.cidr_block[1]
    availability_zone = "eu-west-3a" 
    tags = {
        Name: "learning-subnet-1"
    } 
}

# Type Constraints in Variables using object

variable "cidr_block" {
    description = "cidr-block for vpc and subnet"
    default = "10.0.45.0/24"
    type = list(object({
        cidr_block = string
        Name = string
    }))
}

resource "aws_vpc" "learning-vpc" {
    cidr_block = var.cidr_block[0].cidr_block
    tags = {
        Name: var.cidr_block[0].Name
        vpc_env: "dev"
    }
}
resource "aws_subnet" "learning-subnet" {
    vpc_id = aws_vpc.learning-vpc.id
    cidr_block = var.cidr_block[1].cidr_blocksss
    availability_zone = "eu-west-3a" 
    tags = {
        Name: var.cidr_block[1.Name
    } 
}