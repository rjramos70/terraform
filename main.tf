# Define the provider template
provider "aws" {
  profile = "default"
  region = "eu-west-1"
}

# Defining a IAM group with name 'app_ami'
data "aws_ami" "app_ami" {
  most_recent  =  true

  # Define filters
  filter {
    name    = "name"
    values  =  ["bitnami-tomcat-*-x86_64-hvm-ebs-nami"]
  }
  
  filter {
    name    = "virtualization-type"
    values  =  ["hvm"]
  }

  owners  =  ["979382823631"]  # Bitnami
  
}

# Define a S3 resource
resource "aws_instance" "blog" {
  ami            =  data.aws_ami.app_ami.id
  instance_type  =  var.instance_type

  tags  =  {
    Name  =  "Learning Terraform"
  }
}
