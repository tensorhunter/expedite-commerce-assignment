.PHONY: plan
plan:
	terraform plan

.PHONY: apply
apply:
	terraform apply -auto-approve

.PHONY: destroy
destroy:
	terraform destroy -auto-approve
