# Terraform Beginner Bootcamp 2023


## Semantic Versioning

This project ius going to use Sematic versioning for its tagging    [Semver.org](https://semver.org/)   

The general Format:
**MAJOR.MINOR.PATCH**, eg. `1.0.1`  

Given a version number **MAJOR.MINOR.PATCH**, increment the:
- **MAJOR** version when you make incompatible API changes 
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Consideration for Linux Distribution

This project is built against Ubuntu. Please check your Linux distribution and change according to distribution needs.

[Linux Version](https://linuxize.com/post/how-to-check-linux-version/)  

Example of checking OS version
```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Install Terraform CLI
There were issues encountered witht he terraform installation due to gpg keyring changes. In irder to solve this issue, we reffered to the latest install CLI  instructions via the terraform website. We also changed the scripting as we automated the installation process.

[Terraform Installation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)


### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg deprecation issues, we noticed that the bash scripts involved more code, so we decided to create a bash script to install Terraform. 

### Shebang Considerations
Shebang was the special character sequence used at the beginning of the script. It tells the bash script what program will interpret the script.
We used:
```
#!/usr/bin/env bash
```

- To aid portability  as it helps ensure the script runs regardless of where the intepreter is located in the system.
- Will search user's PATH for the bash executable.

[Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) 

### Execution Considerations
When executing the bash script, we can use the `./` shorthand notation to execute the bash script.
e.g ` ./bin/install_terraform_cli`

If we are using a script in .gitpod/yml, we need to point the script to a program to interpret. 
e.g `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations
We needed to make our basch script executable, so we changed the linux permission for the file to be executable at user mode.

To view permissions on a file e.g `./bin/install_terraform_cli`

```
ls -la ./bin/install_terrraform_cli
```

Command to change file permision

```
chmod u+x ./bin/install_terraform_cli
```
Alternatively

```
chmod 744 ./bin/install_terraform_cli
```

[Chmod](https://en.wikipedia.org/wiki/Chmod)

#### Bash Script 
Bash script Location: [./bin/install_terraform_cli](./bin/install_terraform_cli)



- This keeps the gitpod task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allows for debugging and executing terraform manually.
- This allows for portability

#### Gitpod Lifecycle
We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

[gitpod Lifecycle](https://www.gitpod.io/docs/configure/workspaces/tasks)

## Working with Env Vars

### Env command
We can list out all environment variables using the `env` command.

To filter specific commands env vars using grep eg. `env | grep AWS_`.

### Setting And Unsetting Env vars

In the terminal we can set using `export HELLO = world`

We can unset using `unset HELLO `

We can set an env var temporarily when just runnning a command
```sh
HELLO = `world` ./bin/print_message
```

\Within a bash script we can set env without writing export eg.

```
#!/usr/bin/env bash

HELLO = 'world'

echo $HELLO
```

### Printing  Vars

Env vars can be printed using echo eg. `echo $HELLO`

### Scoping of Env Vars
When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

If you want an env var to persist across all future bash terminal opened, you neeed to set env vars in your bash profile. eg. `.bash_profile`

### Persisting Env vars in Gitpod
We can persist env vars into gitpod by storing them in Gitpod Secrets storage.
```
gp env HELLO = 'world'
```
All future workspaces launched will set the env vars for all bash terminal opened in those workspaces.

## AWS CLI installation
AWS CLI is installed for this project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Install AWS CLI](https://docs.aws.amazon.com/cli/v1/userguide/install-linux.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check to see if our AWS credentials is configured correctly by running:
```sh
aws sts get-caller-identity
```
If successful you should see a json payload that looks like this:

```json
    "UserId": "AIKF4Y2OCNAGIIGDI5BMW",
    "Account": "123548679984",
    "Arn": "arn:aws:iam::123548679984:user/Fikayo_terraform"
```

We had to make an AWS User and generate access tokens for the user 



## Terraform Basics

### Terraform Registry
 Providers and Modules are sourced from terraform rregistry which is located at [Terraform.io](https://registry.terraform.io/)

 - **Providers** is an interface to API'S that will allow creation of resources in terraform.   
 - **Modules** are a way to make terraform codes moodular, portable and shareable.  

[Random Module used ](https://registry.terraform.io/providers/hashicorp/random/latest/docs)
 ### Terraform Console
 To get a List of terraform commands, we simply type `Terraform`

#### Terrafom Init
`terraform init`    
At the start of a new terraform project, we type `terraform Init` to download the binaries for the terraform providers what will be used.

#### Terraform plan
`terraform plan`    
 This command gives a bleuprint of the changes terraform is going to apply without applying them in order to make sure they align with our expectations.

 We can outpuut this plan to be passed to an apply, but often you can ignore outputting

 #### Terraform Apply
 `terraform apply`  
 This command gives the go-ahead to apply the changes to our infasctructure that terraform has planned.

It ususally prompts us to either apply the changes or not.
To have it automatically apply the changes, we use the command:
```
terraform apply --auto-approve
```
#### Terraform Destroy
`terraform destroy`     
This will destroy resources which have been created by the terraform apply command. 

It also prompts for an approve input but this can be skipped by using the flag :
```
terraform destroy --auto-approve
```

### Terraform Lock Files
`terraform/lock.hcl`  conntains the locked versioning for the providers or moodules that should be used with this project. If a new provider is included, the `terraform init` command should be used in order to include the new provider in the lock file

The terraform lock file should be committed to the version control system eg. Github

### Terrafotm State Files

`terraform.tfstate` contains information about the current state of your infastructure.     
This file **should not** be committed to your version control system as it could contain sensitive data.

If the file is lost, you lose knowing the state of your infrastructure.

`terraform.tfstate.backup` is the prvious state file state

#### Terraform Directory
It contains binaries of terraform providers 

## Terraform Cloud
[Terraform Cloud](https://app.terraform.io/) Having created an account in terraform cloud,  We had to create a project and a workspace inside the project    
- **Project** - A collection of related Terraform configurations.   
- **Workspace** - An isolated environment within a project for managing infrastructure configurations.

Terraform cloud was added to the infastructure using the following code:
```
terraform {
  cloud {
    organization = "FaksOrg"

    workspaces {
      name = "terra-house-1"
    }
  }
}
```
#### CLI Driven runs
After including the code into the infastructure, we had to login to the cloud from the CLI

`terraform login`

An API token was then generated from a browser and stored in
```
 /home/gitpod/.terraform.d/credentials.tfrc.json
```

After the token was generated, we used the command `terraform init` to initialize the workspace and `terraform apply` to start the first run with the workspace.

N:B If you are working in main branch and want to take the changes made to a new branch, run the following commands:
```
git pull
git fetch
git add .
git stash save

git checkout {branch name}

git statsh change apply
```

## References 
- [Linux Version](https://linuxize.com/post/how-to-check-linux-version/)    
- [Terraform Installation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))   
- [Chmod](https://en.wikipedia.org/wiki/Chmod)  
- [gitpod Lifecycle](https://www.gitpod.io/docs/configure/workspaces/tasks)