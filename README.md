## Terraform aws Resources

A simple notes about terraform resources.

### What is a Resource?

- **Resource** in terraform is the core building block used to create, update, and delete infrastructure components.
- **Resource** describes one real-world infrastructure object that Terraform manages.
- Each resource block describes one or more infrastructure object.

### Resource Syntax
```bash
resource "<provider>_<resourceType>" "variable name" {
    parameters
}
```
Here resource type = provider_resourceType
 -   resource name = variable name

## In Terraform Config file add the below code in it.

```bash

# Tags are key value pairs in aws.
# syntax-  mykey: "myvalue"

resource "aws_vpc" "learning-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name: "development"
        vpc_env: "dev"
    }
}

## Creating a resource for a non-existing resource, in terraform we can reference the resources in the same context.

resource "aws_subnet" "learning-subnet" {
    vpc_id = aws_vpc.learning-vpc.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "eu-west-3a"  
}
```

If you want to delete a specific resource from the terraform config file, we have 2 methods:
1. remove the specific resource data from configuration file
2. use the following command:
   ```bash
   # Syntax: terraform destroy -target resource type.resource name
   terraform destroy -target aws_subnet.learning-subnet
   ```
Then go to the path of the file in terminal and execute the below commands.

```bash
terraform plan
```

**Terraform plan** - It shows what Terraform will change before it actually makes any changes.

- terraform plan performs a dry run by comparing the desired configuration with the current state and shows the actions Terraform will take without modifying infrastructure.

When we execute the above command then the below things will happen.
- Reads Terraform configuration files (.tf).
- Loads current state file.
- Compares desired state vs actual state.
- Generates a change plan.
  

## Why terraform plan Is Important
- Prevents accidental changes
- Shows create / update / destroy actions
- Helps in code review & approvals
- Essential for CI/CD pipelines

**Best Practices:**
- Always run plan before apply.
- Save plan in production.
- Review destroy actions carefully.
- Use in CI/CD for approvals.

**IMPORTANT NOTES:**
- Plan does not change resources.
- Output depends on current state.
- Plan can differ if state changes externally.
