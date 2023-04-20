resource "aws_key_pair" "provisioner" {
  key_name   = "provisioner-key"
  public_key = data.local_file.provisioner_public_key.content
}

resource "aws_instance" "gitlab" {
  ami                    = "ami-06640050dc3f556bb"
  instance_type          = "t3.medium"
  key_name               = "provisioner-key"
  vpc_security_group_ids = [aws_security_group.gitlab.id]
  subnet_id              = aws_subnet.main.id
  root_block_device {
    volume_size           = 50
    delete_on_termination = true
    volume_type           = "gp3"
  }
  tags = {
    Name = "GitLab"
  }
}

resource "aws_instance" "runner" {
  ami                    = "ami-06640050dc3f556bb"
  instance_type          = "t2.micro"
  key_name               = "provisioner-key"
  vpc_security_group_ids = [aws_security_group.runner.id]
  subnet_id              = aws_subnet.main.id
  iam_instance_profile   = aws_iam_instance_profile.fargate.name
  root_block_device {
    volume_size           = 50
    delete_on_termination = true
    volume_type           = "gp3"
  }
  tags = {
    Name = "Runner"
  }
}