export TF_IN_AUTOMATION=true
export TF_VAR_namespace=ivendi
export TF_VAR_aws_assume_role_arn=""

export TF_CLI_ARGS_init="-backend-config=region=eu-west-2 -backend-config=key=grafana-monitoring/cloudfront/dev/terraform.tfstate -backend-config=bucket=ivendi-dev-terraform-state -backend-config=dynamodb_table=ivendi-dev-terraform-state-lock -backend-config=encrypt=true"

export TF_VAR_region=eu-west-2
export TF_VAR_stage=dev
export TF_VAR_aws_region=eu-west-2

rm .terraform.lock.hcl

terraform init
terraform workspace select euwest2dev || terraform workspace new euwest2dev

#terraform state list
terraform plan -input=false -out=tfplan

#echo "run - terraform apply tfplan"

terraform apply -input=false -auto-approve tfplan