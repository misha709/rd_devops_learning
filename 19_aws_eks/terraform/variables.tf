variable "aws_region" {
  description = "Region where AWS resources will be deployed"
  type        = string
  default     = "eu-west-1"
}

variable "project_tag" {
  description = "Tag used to identify resources related to the AWS EKS project"
  type        = string
  default     = "rd-19-aws-eks"
}