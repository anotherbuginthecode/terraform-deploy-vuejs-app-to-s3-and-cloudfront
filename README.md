![banner](https://i.imgur.com/1RIB1tm.png)

A small project to learn some DevOps stuff like IAC and CI/CD.

The goal is to deploy a Basic Vue app to AWS using Amazon S3 and CloudFront Distribution.

The infrastructure was provided using Terraform.

GitHub actions were used to update the infra and deploy the new version of the web app into the S3 bucket and invalidate the CloudFront Cache.

A full explanation of the project can be found in my article written in medium here.

## Repository structure

```
root/
├── LICENSE
├── README.md
├── terraform/
└── webapp/
```

**terraform:** it contains the definition of the AWS infrastructure and resources.

**webapp:** it contains the vue app. It is created using the Vue CLI `vue create webapp`.

## Execute Terraform locally
If you want to run Terraform locally:
- Go under terraform folder.
- Create **`terraform.tfvars`** file and declare all necessary variables defined in **`variables.tf`** file.
- Create **`backend.tfvars`** and define your `access_key` and `secret_key`
- Run the command `terraform init -backend-config backend.tfvars`
- Then, 
``` 
terraform plan -var-file=terraform.tfvars -out=out.terraform; terraform apply out.terraform; rm out.terraform
```
