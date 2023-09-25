# Terraform Beginner Bootcamp 2023 - Week 1


## Root Module Structure

Our module structure is as follows:

```
Project Root/
│
├── main.tf - Everything else
├── variables.tf - stores structure of input variables
├── providers.tf - defined required providers and their configurations
├── outputs.tf - store our outputs
├── terraform.tfvars - data of variables to load into our terraform project
└── README.md - required for our root modules
```


[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
