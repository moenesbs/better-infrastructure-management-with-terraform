resource "aws_ssm_parameter" "first_cicd_resource" {
  name  = "/terraform_workshop/provider_config/${random_pet.name.id}"
  type  = "String"
  value = "Hello Terraform! This resource has been created by CICD"
}

resource "random_pet" "name" {
  length = 2
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
