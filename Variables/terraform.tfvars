subnet_cidr_block = "10.0.10.0/24"
vpc_cidr_block = "10.0.0.0/16"

# Replicate same infrastructure for different environment.

environment = "development"

# Type Constraints using string

cidr_block = [ "10.0.0.0/16","10.0.10.0/24" ]

# Type Constraints in Variables using object
cidr_block = [
    {cidr_block= "10.0.0.0/16", Name= "first-vpc"},
    {cidr_block= "10.0.10.0/24", Name = "first-subnet"}
]