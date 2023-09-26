# Terraform Beginner Bootcamp 2023 - Week 1


## Root Module Structure

Our module structure is as follows:

```
Project Root/
│
├── main.tf - Everything else
├── variables.tf - stores structure of input variables and validation
├── providers.tf - defined required providers and their configurations
├── outputs.tf - store our outputs
├── terraform.tfvars - data of variables to load into our terraform project
└── README.md - required for our root modules
```

## Migrating To Local state

We migrated back from cloud to the local state and  some steps were involved:

- Delete the `.terraform.lock.hcl` and `.terraform` file
- Run the `terraform init` command 

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)


## Terraform Cloud Variables
In terraform we cans et two kinds of variables:
 - Environment variables - those that you would normally set in your bash terminal e.g AWS Credentials
 - Terraform Variables - those that you would normally set in your tfvars file

 We can set terraform cloud variables to be sensitive so they are not shown visibly to the UI.

 ### Loading Terraform variables
 We can use the `-var` flag to set an input variable or override a variable in the tfvars file e.g `terraform -var user user_if = "my user`

 ### var-file flag

 Research this flag

 ### terraform.tvfars
 This is the default file to load in terraform variables.

 ### auto.tfvars
 TODO: Document this functionality

 ### Order of terraform variables
 TODO: Document which terraform variables take precedence

 ### Fix missing Resources with Terraform Import 
We found ways to restore our terraform state file if it gets lost by using the import block to import our s3 bucket from aws 

N:B **This command might not work for all AWS services**

```
terraform import aws_s3_bucket.bucket bucket-name
```

[Import for S3 Buckets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix manual configuration
If any changes were made to our cloud infastructure through ClickOps, running `terraform plan`, terraform will attempt to put our infastructure back into the expected state ficing configuration drift.