resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "GitLab VPC"
  }
}

resource "aws_eip" "gitlab" {
  instance = aws_instance.gitlab.id
  vpc      = true
}

resource "aws_eip" "runner" {
  instance = aws_instance.runner.id
  vpc      = true
}