# Nginx on AWS EC2 and ELB using Terraform

Nginx server on:

- Elastic Load Balancer

- EC2 AWS linux AMI

- Costumized VPC with 2 public subnets

- 2 EC2 instances

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