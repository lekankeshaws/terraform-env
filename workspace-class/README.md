## list workspaces
```
terraform workspace list
```

## Create workspace
```
terraform workspace new sbx
terraform workspace new prod
terraform workspace new dev
```
## show specific workspace
```
terraform workspace show
```
## Next creating tfvars file
```
touch sbx.tfvars dev.tfvars prod.tfvars
```
## How to tag in workspace
```
you use this command "${terraform.workspace}-kesh-vpc" and if you want to add a upper case do upper("${terraform.workspace}-kesh-vpc")
```
## To switch to another workspace
```
terraform workspace select <name of workspace>
```
## How do we run terraform plan in this new approach
## first step verify the workspace
```
terraform worspace show
```
## Then run the command
```
terraform plan -var-file sbx.tfvars
```
## Unlock state file
```
terraform foce-unlock <copy the id specified>
```
## How to Destroy
```
terraform workspace select sbx
terraform destroy -var-file sbx.tfvars
```




