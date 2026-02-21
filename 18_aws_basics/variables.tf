variable "aws_region" {
    description = "Region where AWS resources will be deployed"
    type        = string
    default     = "eu-west-1"
}

variable "project_tag" {
  description = "Tag used to identify resources related to the AWS basics project"
  type        = string
  default     = "rd-18-aws-basics"
}