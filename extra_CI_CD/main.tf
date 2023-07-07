resource "aws_ssm_parameter" "first_cicd_resource" {
  name  = "/terraform_workshop/provider_config/${random_pet.name.id}"
  type  = "String"
  value = "Hello Terraform! This resource has been created by CICD"
}

resource "random_pet" "name" {
  length = 2
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}
