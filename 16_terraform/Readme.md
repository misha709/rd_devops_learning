# Terraform

> **TODO:** These tasks will be completed after getting access to AWS

## Task Description

### Task 1: Create VPC with Servers Using Terraform Modules

Create a VPC with two servers in public and private subnets using Terraform, applying modules:
* Create a module for VPC
* Create a module for subnets
* Create a module for EC2 instances
* Use these modules in the main configuration file to create the infrastructure

### Task 2: Import Existing Resources into Terraform Configuration

Import existing resources into Terraform configurations:
* Create several resources manually using AWS Management Console
* Import these resources into Terraform configuration files using the `terraform import` command
* Ensure that Terraform creates identical infrastructure