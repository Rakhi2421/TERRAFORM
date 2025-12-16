## Terraform aws Outputs

A simple notes about terraform output.

### What is output?

- **output** is a Terraform block type.
- **Terraform output** is used to expose important infrastructure values after deployment, making them easy to access and reuse across modules and automation workflows.
- Terraform outputs are used to display useful information about the created infrastructure after terraform apply.
- Outputs show important values such as:
  - Instance public IP
  - Load balancer DNS name
  - VPC ID, Subnet IDs, etc.
  - They help in sharing values between Terraform modules.

Outputs can be used by:
- Users (CLI display)
- Other Terraform configurations
- Automation scripts / CI-CD pipelines

----

  Output Block Syntax:

  ```bash
output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.my_ec2.public_ip
}
```

When are Outputs Displayed?

```bash
# Automatically shown after:
terraform apply

# Can be viewed anytime using:
terraform output
```

Terraform Output Commands

```bash
# Show all outputs
terraform output

# Show a specific output
terraform output instance_public_ip

# Show output in JSON format
terraform output -json
```

Sensitive Outputs

To hide sensitive values (like passwords, tokens):

```bash
output "db_password" {
  value     = aws_db_instance.mydb.password
  sensitive = true
}
```
Value will not be printed on the CLI.
