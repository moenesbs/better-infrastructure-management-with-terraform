resource "aws_ssm_parameter" "first_cicd_resource" {
  name  = "/terraform_workshop/provider_config/${random_pet.name.id}"
  type  = "String"
  value = "Hello Terraform! This resource has been created by CICD"
}

resource "random_pet" "name" {
  length = 2
}



resource "aws_iam_role" "notebook_role" {
  name = "sagemaker_notebook_role-${var.student_name}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = []

  inline_policy {
    name = "S3_access"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["s3:ListAllMyBuckets", "s3:ListBucket", "s3:HeadBucket"]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }
}


resource "aws_sagemaker_notebook_instance" "notebook_instance" {
  name                   = "example-notebook-instance"
  instance_type          = "ml.t2.medium"
  role_arn               = aws_iam_role.notebook_role.arn
}


