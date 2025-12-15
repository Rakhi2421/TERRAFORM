## Terraform aws Data Source

A simple notes about terraform data source.

### What is a Data Source?

- A **data source** in Terraform is used to fetch and read information about existing infrastructure resources that are not created or managed by Terraform
- **Data sources** allow Terraform to read existing infrastructure without managing its lifecycle.
- **Data sources** are used to reference infrastructure created outside Terraform.
- Resources create, data sources read.

## Syntax

```bash
data "<PROVIDER>_<TYPE>" "<NAME>" {
  # filters or identifiers
}
```

## In Terraform Config file add the below code in it.

```bash
data "aws_vpc" "existing-vpc" {
    default = true
}

resource "aws_subnet" "subnet-createusingdatasodurce" {
    vpc_id = data.aws_vpc.existing-vpc.id
    cidr_block = "172.23.48.0/24"
    availability_zone = "eu-west-3a"  
}
```

In Programming Languagae.

- Provider = import library
- Resource/data Source = function call of library
- arguments = parameters of a function.
