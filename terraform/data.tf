data "local_file" "provisioner_public_key" {
  filename = "${path.module}/../id_rsa.pub"
}