output "gitlab_public_dns" {
  description = "GitLab public DNS"
  value       = resource.aws_eip.gitlab.public_dns
}

output "runner_public_dns" {
  description = "GitLab public DNS"
  value       = resource.aws_eip.runner.public_dns
}

output "runner_subnet" {
  description = "The ID of the subnet where the runner is deployed"
  value       = resource.aws_subnet.main.id
}

output "runner_security_group" {
  description = "The ID of the runner security group"
  value       = resource.aws_security_group.runner.id
}