# GitLab

1. Generate SSH key (`./id_rsa`, and `./id_rsa.pub`)
2. Set Ansible vault password (`./ansible/.vault-password-file`)

## Terraform

```bash
cd terraform
make plan
make apply
```

Make note of the output values for use in the Ansible. For example:

```
gitlab_public_dns = "ec2-XXX-XXX-XXX-XXX.compute-1.amazonaws.com"
runner_public_dns = "ec2-XXX-XXX-XXX-XXX.compute-1.amazonaws.com"
runner_security_group = "sg-XXXX"
runner_subnet = "subnet-XXXX"
```

## Ansible

Using the Terraform output:

1. Update the hostnames in `hosts` with the DNS names for GitLab and the Runner
2. Update the runner security group and subnet IDs in `vars/main.yml`

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