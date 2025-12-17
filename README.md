# AWS EC2 + Docker Nginx Deployment (Custom VPC)

## Project Overview

This project demonstrates **end-to-end provisioning of AWS infrastructure from scratch** and deployment of an **NGINX Docker container on an EC2 instance**.  
All resources are created manually following **AWS best practices**, without modifying default AWS resources.

The goal of this project is to understand **networking fundamentals, EC2 provisioning, Docker containerization, and secure internet access using custom VPC architecture**.

---

## Architecture Overview

The infrastructure is designed using a **custom VPC** connected to the internet via an **Internet Gateway**, enabling public access to an EC2 instance that hosts an NGINX Docker container.

### Architecture Flow

User → Internet → Internet Gateway → Route Table → Public Subnet → EC2 Instance → Docker → NGINX

---

##  Infrastructure Components

### 1️⃣ Custom VPC
- Created a dedicated VPC with a private IP address range.
- Provides isolated networking for the application.
- Default AWS VPC is **not modified**, as per best practices.

### 2️⃣ Public Subnet
- Subnet created inside the custom VPC.
- Associated with a route table that allows internet access.
- Auto-assign public IP enabled for EC2 instances.

### 3️⃣ Internet Gateway (IGW)
- Internet Gateway attached to the custom VPC.
- Enables communication between AWS resources and the internet.

### 4️⃣ Route Table
- Custom route table created and associated with the public subnet.
- Route added:
  - `0.0.0.0/0 → Internet Gateway`
- Allows outbound and inbound internet traffic.

### 5️⃣ Security Group
- Acts as a virtual firewall for the EC2 instance.
- Inbound rules:
  - **SSH (22)** – for remote access
  - **HTTP (80)** – to access NGINX
- Outbound traffic allowed to all destinations.

---

## 💻 EC2 Instance Provisioning

- Launched an EC2 instance inside the public subnet.
- Assigned a public IP for internet access.
- Security group attached to control inbound and outbound traffic.
- Used user data / manual setup to install required packages.

---

## 🐳 Docker & NGINX Deployment

### Docker Setup
- Docker installed on the EC2 instance.
- Docker service enabled and started.

### NGINX Container Deployment
- Pulled the official NGINX Docker image from Docker Hub.
- Ran the container exposing port **80**.
- NGINX service becomes accessible via the EC2 public IP.

Example:
```bash
docker run -d -p 80:80 nginx
```
## Application Access

Once deployment is complete, the NGINX application can be accessed using:

http://<EC2-Public-IP>:8080
Successful access confirms:
- VPC networking is correctly configured
- Internet Gateway and route table are working
- Security group allows HTTP traffic
- Docker container is running successfully

## Best Practices Followed
- Created infrastructure from scratch
- Did not modify default AWS VPC or subnets
- Used least-privilege security group rules
- Isolated networking using custom VPC
- Followed clean and modular AWS architecture

## Key Learnings
- AWS VPC networking fundamentals
- Internet Gateway and routing concepts
- EC2 provisioning in a custom subnet
- Docker installation and container deployment
- Secure public access using Security Groups

## Future Enhancements
- Automate infrastructure using Terraform
- Use Application Load Balancer
- Implement Auto Scaling Group

Add HTTPS using ACM & ALB

Containerize using Docker Compose

## Conclusion
This project provides hands-on experience in AWS infrastructure provisioning, networking, and containerized application deployment, making it suitable for DevOps, Cloud Engineer, and AWS interview preparation.
