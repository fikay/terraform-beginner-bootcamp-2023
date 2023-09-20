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

## References 
- [Linux Version](https://linuxize.com/post/how-to-check-linux-version/)    
- [Terraform Installation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))   
- [Chmod](https://en.wikipedia.org/wiki/Chmod)  
- [gitpod Lifecycle](https://www.gitpod.io/docs/configure/workspaces/tasks)