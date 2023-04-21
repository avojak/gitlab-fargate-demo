# GitLab Fargate Runners Demo

Demonstration of setting up autoscaled GitLab runners using AWS Fargate.

Emphasis on this being a **demo** - if you plan to deploy this in a production setting, there are *many* things that should be changed to improve the security posture.

## Prerequisites

1. Generate SSH key (`./id_rsa`, and `./id_rsa.pub`)
2. Set Ansible vault password (`./ansible/.vault-password-file`)
3. Add AWS access key ID and secret key to `./terraform/.aws/credentials`

## Docker

Builds the Fargate driver image.

```bash
cd docker
make image
make push
```

## Terraform

```bash
cd terraform
make plan
make apply
```

Make note of the output values for use in the Ansible. For example:

```
ecs_task_revision = 3
gitlab_public_dns = "ec2-XXX-XXX-XXX-XXX.compute-1.amazonaws.com"
runner_public_dns = "ec2-XXX-XXX-XXX-XXX.compute-1.amazonaws.com"
runner_security_group = "sg-XXXX"
runner_subnet = "subnet-XXXX"
```

## Ansible

Using the Terraform output:

1. Update the hostnames in `hosts` with the DNS names for GitLab and the Runner
2. Update the runner security group and subnet IDs in `vars/main.yml`
3. Update the ECS task revision in `vars/main.yml`

### GitLab Server

First install the GitLab server:

```bash
cd ansible
make install-gitlab
```

SSH and grab the initial root password from `/etc/gitlab/initial_root_password`, then login and change it ASAP.

### GitLab Runner

Unfortunately the `geerlingguy.gitlab` role doesn't copy the `gitlab.rb` config until after the first reconfigure, so we can't pre-populate the runner token with our own value. Instead, we need to copy the registration token from the UI and encrypt it:

```bash
cd ansible
ansible-vault encrypt_string --vault-password-file .vault-password-file TOKEN
```

Then add the encrypted string to `vars/main.yml`. 

Finally, install the runner:

```bash
make install-runner
```

## References

- [Autoscaling GitLab CI on AWS Fargate](https://docs.gitlab.com/runner/configuration/runner_autoscale_aws_fargate/#step-1-prepare-a-container-image-for-the-aws-fargate-task)
- [Fargate Driver Debian](https://gitlab.com/tmaczukin-test-projects/fargate-driver-debian/-/blob/master/Dockerfile)
- [AWS Fargate driver for Custom Executor](https://gitlab.com/gitlab-org/ci-cd/custom-executor-drivers/fargate/-/tree/v0.2.0/docs?ref_type=tags#configuration)
- [Attach IAM role to Amazon EC2 instance using Terraform](https://skundunotes.com/2021/11/16/attach-iam-role-to-aws-ec2-instance-using-terraform/)
- [ECS ContainerDefinition](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html)
- [ECS ContainerDefinition private registry auth](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/private-auth.html)
- [Registering a GitLab Runner using a pre-made config.toml](https://stackoverflow.com/a/54665350/3300205) (Re: [gitlab-runner #3553](https://gitlab.com/gitlab-org/gitlab-runner/-/issues/3553#note_108527430))