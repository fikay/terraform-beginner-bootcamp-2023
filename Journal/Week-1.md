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

### Fix using Terraform Refresh

```tf
terraform apply -refresh-only -auto-approve
```
## Terrafom Modules
It is recommmended to place modules in a `modules` directory when locally developing modules but you can name the modules to anything you want
### Modules sources

Using the source we can import the source from various places eg:   
-Locally    
-GitHub     
-Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```
#### Passing input Variables
To pass in input Variables to the module we include this in the module and make sure the variables are defined in the modules `variables.tf` and the main `variables.tf`

N:B We do not need to apply the conditions in the main `vatriables.tf` as validation is already being done in the module.

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  UserUuid = var.UserUuid
  bucket_Name = var.bucket_Name
}
```


[Modules sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations using ChatGPT To write Terraform

LLMs such as ChatGPT may not be trained on the latestr documentation or information about terraform,

It may likely produce older examples that could be deprecated. Often affecting providers.

## Uploading Files to S3 Bucket 
In order to uplload files to the S3 bucket such as the `index.html` used in our static website, terrform provides us with code used for that:

```tf
resource "aws_s3_object" "object" {
  bucket = "your_bucket_name"
  key    = "new_object_key"
  source = "path/to/file"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("path/to/file")
}
```

link : [S3 Objects](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object)

### Working with files in Terraform 

#### Path Variable
In terraform there is a special variable called path that allows us to reference local paths:
Path.module - get path for current module   
path.root - get path for root module  
[References to Values](https://developer.hashicorp.com/terraform/language/expressions/references)

### File functions

#### File exists function
This checks if a file exists at a given path.
```
variable "index_html_filepath" {
  type        = string
  description = "Path to the index.html file"

  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The specified 'index_html_filepath' does not exist or is not a valid file path."
  }
}
```
[file exists](https://developer.hashicorp.com/terraform/language/functions/fileexists)
### Filemd5

Function that hashes the contents of a given file rather than a literal string.

[Filemd5](https://developer.hashicorp.com/terraform/language/functions/filemd5)

## Terraform Locals
A local value assigns a name to an expression, so you can use the name multiple times within a module instead of repeating the expression.
```
locals  {
  s3_origin_id = "MyS3Origin"
}

```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)
## Terraform Data Sources
This allows us to source data from cloud resources.

This is ueseful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

```

[Data Sources](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)

## Working with JSON
We use the json encode to create the json policy inline in the hcl
```
> jsonencode({"hello"="world"})
{"hello":"world"}

```
[Json Encode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)


### Discovery 
After setting up the cloudFront, we tried to load up the website but Distribution domain name kept downloading the file.   
This was a result of not specifying the content type in the Object.

```tf
esource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_Bucket.bucket
  key    = "error.html"         # Specify the key (path) in the bucket
  source = var.error_html_filepath
  content_type = "text/html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(var.error_html_filepath)
}
```

Once that was specified, we went into the cloudFront invalidations and cleared out the cache using `/*` for it to then work.

N.B Make sure the pages are valid HTML

### Changing the lifecycle of Resources

[Meta Arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data
Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

[Terraform Data](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

## Provisioners
provisioners allow you to execute commands on compute instances e.g AWS CLI command.

They are not recommended for use by Hashicorp because configuration Management tools such as Ansible are a better fit, but the functionality exists.

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec
This will execute commands on the machine runningt he terraform commands eg, Plan apply

```
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}

```

### Remote-exec

This will execute commands on a machine which you target. You will need to provide credential such as ssh to get into the machine.

```
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}

```

## For Each Expressions

For each allows us to enumerate over complex data types.
```
# my_buckets.tf
module "bucket" {
  for_each = toset(["assets", "media"])
  source   = "./publish_bucket"
  name     = "${each.key}_bucket"
}

```

Mostly useful when you are creating multiples of a cloud resource and you want to reduce the amount of repetitive terraform code.
[For each](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)