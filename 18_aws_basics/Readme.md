# AWS Basics

## Task 1: Create and configure VPC

### Step 0: Terraform setup

- Create `main.tf`, `outputs.tf`, `variables.tf`.
- Configure AWS provider and region in `main.tf`.
- Run: `terraform init`

### Step 1: Create a new VPC

Add to `main.tf`:

```hcl
resource "aws_vpc" "mi-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name    = "mi-rd-vpc"
    project = var.project_tag
  }
}
```

Run: `terraform apply`

![VPC result](images/vpc_output.png)

### Step 2: Add subnets to VPC

Add to `main.tf`:

```hcl
resource "aws_subnet" "mi-public-subnet" {
  vpc_id     = aws_vpc.mi-vpc.id
  cidr_block = "10.0.0.0/24"
  tags = { Name = "mi-rd-public-subnet"; project = var.project_tag }
}

resource "aws_subnet" "mi-private-subnet" {
  vpc_id     = aws_vpc.mi-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = { Name = "mi-rd-private-subnet"; project = var.project_tag }
}
```

Run: `terraform apply`

![Subnets result](images/create_subnets.png)

### Step 3: Internet Gateway and public routing

Add to `main.tf`: IGW, route table (0.0.0.0/0 → IGW), and route table association for the public subnet.

```hcl
resource "aws_internet_gateway" "mi-gateway" {
  vpc_id = aws_vpc.mi-vpc.id
  tags = { Name = "mi-gateway"; project = var.project_tag }
}

resource "aws_route_table" "mi-public-rt" {
  vpc_id = aws_vpc.mi-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mi-gateway.id
  }
  tags = { Name = "mi-rd-public-rt"; project = var.project_tag }
}

resource "aws_route_table_association" "mi-public-subnet-assoc" {
  subnet_id      = aws_subnet.mi-public-subnet.id
  route_table_id = aws_route_table.mi-public-rt.id
}
```

Run: `terraform apply`

![Gateway result](images/add_intenet_gateway.png)

---

## Task 2: Security Groups and Network ACLs
## Task 3: Launch EC2 Instance
## Task 4: Assign Elastic IP (EIP)
