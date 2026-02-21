# AWS Basics

## Task 1: Create and configure VPC

### Step 0: Set up Terraform

1. Create the base files for your project: `main.tf`, `outputs.tf`, and `variables.tf`.
2. In `main.tf`, configure the required provider (AWS) and specify your region and other variables as needed.
3. Initialize your Terraform working directory by running:
```
terraform init
```

### Step 1: Create a new VPC
Add the following block to your `main.tf` file to define your VPC:
```hcl
resource "aws_vpc" "mi-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name    = "mi-rd-vpc"
    project = var.project_tag
  }
}
```
Apply the configuration to create the VPC:
```
terraform apply
```

The image below shows an example of the created VPC:

![alt text](images/vpc_output.png)

### Step 2: Add subnets to VPC
### Step 3: Configure Internet Gateway

### Step 2: Query Children with Their Institutions and Classes

## Task 2: Configure Security Groups and Network ACLs
## Task 3: Launch an EC2 Instance
## Task 4: Assign an Elastic IP (EIP)
