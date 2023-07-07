resource "aws_ssm_parameter" "first_cicd_resource" {
  name  = "/terraform_workshop/provider_config/${random_pet.name.id}"
  type  = "String"
  value = "Hello Terraform! This resource has been created by CICD"
}

resource "random_pet" "name" {
  length = 2
}

data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

resource "aws_instance" "this" {
  ami = data.aws_ami.this.id
  instance_market_options {
    spot_options {
      max_price = 0.0031
    }
  }
  instance_type = "t4g.nano"
  tags = {
    Name = "test-spot"
  }
}
