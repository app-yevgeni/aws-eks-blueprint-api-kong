<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/5d46c4f5-e511-4ab2-9d82-a2908bdd8397" />


## AWS | EKS Kong BluePrint
Provisioning an Amazon Elastic Kubernetes Service (EKS) cluster using Terraform allows you to define your entire infrastructure (VPC, subnets, IAM roles, and the cluster itself) as code, ensuring repeatable, version-controlled, and automated deployments.



🎯 Architecture Overview
```
✅ VPC containing Public and Private Subnets
✅ Internet Gateway for outbound internet access
✅ NAT Gateway in the public subnet for private subnet egress
✅ Elastic Kubernetes Service using a Launch Template
✅ EC2 instances in the ASG, scaling in/out automatically
✅ Private resources (like RDS, caches) in the private subnets
```


🧱 Features
```
✔ Fully automated provisioning with Terraform
✔ High availability using multiple subnets in different Availability Zones
✔ Secure connectivity between Application and RDS
✔ Configurable environment variables for database credentials
✔ Easy to extend for other JSON data source
```



🚀 Deployment Options
```
terraform init
terraform validate
terraform plan -var-file="template.tfvars"
terraform apply -var-file="template.tfvars" -auto-approve
```

