.PHONY: init
init:
	ansible-galaxy install -r requirements.yml

.PHONY: install-gitlab
install-gitlab:
	ansible-playbook -i hosts playbook.yml --vault-password-file .vault-password-file --limit gitlab

.PHONY: install-runner
install-runner:
	ansible-playbook -i hosts playbook.yml --vault-password-file .vault-password-file --limit runner