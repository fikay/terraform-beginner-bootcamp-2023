# Terraform Beginner Bootcamp 2023 -  Week 2

## Working with Ruby


## BUNDLER

Bundler is a package manager for ruby. It is the primary way to install ruby packages( known as gems) for ruby

### Install Gems 

you need to create a GemFile and define your gems in that file

```
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then youy need to install the `bundle install` command

This will install the gems on the system globally (unlike nodejs which install packages in a folder claaed node_modules)

A gemfile.lock will be created to lock down the gem versions used in this project.


#### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to tell future ruby scripts  to use the gems  we installed. This is the way to set context


#### Sinatra
Sinatra is a micro web framework for ruby to build web apps.

Great for mock or development servers or for veruy simple projects.
You can create a web server in a single file

[Sinatra](https://sinatrarb.com/)

## Terratowns Mock Server

### Running the web server

We can run the web server by executing the folloowing commands

```rb
bundle install
bundle exec ruby server.rb
```

All code for the server is stored in the ` server.rb` file.

##CRUD

Terraform provider resources utilize CRUD(Create, Read, Update and Delete).