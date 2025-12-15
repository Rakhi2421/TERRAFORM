data "aws_vpc" "existing-vpc" {
    default = true
}

resource "aws_subnet" "subnet-createusingdatasodurce" {
    vpc_id = data.aws_vpc.existing-vpc.id
    cidr_block = "172.23.48.0/24"
    availability_zone = "eu-west-3a"  
}