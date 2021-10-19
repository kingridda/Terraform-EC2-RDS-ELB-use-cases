# Nginx on AWS EC2 using Terraform

Nginx server on:

- EC2 AWS linux AMI

- default VPC

- HTTP (80) and SSH (22) ports are open

- uses a provisioner to install and run the server

## Create the infrastructure
```
terraform init
terraform validate
terraform plan -out myplan.tfplan
terraform apply "myplan.tfplan"
```

## Destroy 
```
terraform destroy
```