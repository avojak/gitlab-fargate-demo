PLAN_FILE := acloudguru.tfplan

.PHONY: format
format:
	terraform fmt -recursive .

.PHONY: init
init:
	terraform init

.PHONY: plan
plan:
	terraform plan -out=$(PLAN_FILE)

.PHONY: apply
apply:
	terraform apply $(PLAN_FILE)

.PHONY: destroy
destroy:
	terraform destroy

.PHONY: clean
clean:
	rm -rf .terraform/
	rm -f .terraform.lock.hcl
	rm -f *.tfstate*
	rm -f *.tfplan