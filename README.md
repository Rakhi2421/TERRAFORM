## Terraform aws Variables

A simple notes about terraform variabless.

### What is a Variable?

- **Terraform variables** are input parameters that allow infrastructure code to be flexible, reusable, and environment-independent.
- Terraform Variables are used to parameterize configurations, allowing you to pass values into Terraform so the same code can be reused across environments (dev, test, prod).
- Variables make Terraform code dynamic and reusable.
- They help avoid hard-coding values
- Values can be overridden without changing the code

 ## Variable Block Syntax:
 ```bash
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
```

## Parts of a Variable Block
|Field          |	Description                                        |
|---------------|----------------------------------------------------|
|variable	      | Block type                                         |
|"instance_type"| Variable name                                      |
|description    | Explains the variable                              |
|type         	| Data type (string, number, bool, list, map, object)|
|default        | Optional default value                             |

## Using a Variable

```bash

resource "aws_vpc" "learning-vpc" {
    cidr_block = var.cidr_block[0]
    tags = {
        Name: "development"
        vpc_env: "dev"
    }
}
```
**var.cidr_block[0] references the variable**

There are 3 ways to pass the value to the input variable.

1. Terraform apply
 - When we use this command, it prompts to enter the value. There we have to enter the required data

2. terraform apply -var "subnet_cidr_block=10.0.30.0/24"
 - We can pass the values to a variable in command only.

3. creating a file with name terraform.tfvars
- If it is created with anothername.tfvars,we have to set a file in command, as terraform looks for terraform.tfvars file.
  ```bash
  terraform apply -var-file anothername.tfvars
  ```

## Variable Types:
Primitive Types
```bash
string
number
bool
```

Complex Types

```bash
   list(string)
map(string)
object({
  name = string
  size = number
})
```

Variable Validation

```bash
variable "instance_type" {
  type = string

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.instance_type)
    error_message = "Instance type must be t2.micro or t3.micro"
  }
}
```
