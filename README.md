# Greg

Simple code generator

## Introduction

Greg is a simple code generator. It generates code based on templates.

## Usage

To create an app use the `greg` command as follows:

    $ greg <app name> --template=<template name>

This will create your app on the current directory.

For example, to create a Roda application:

```bash
$ pwd
/tmp/code
$ ls
$ greg my_awesome_app --template=roda_app
Creating Project:
    [create] .env
    [create] routes/
    [create] routes/main.rb
    [create] spec/
    [create] spec/my_awesome_app/
    [create] spec/spec_helper.rb
    [create] spec/my_awesome_app_spec.rb
    [create] config.ru
    [create] Gemfile
    [create] public/
    [create] my_awesome_app.rb
    [create] views/
    [create] views/welcome.haml
    [create] views/layout.haml
    [create] assets/
    [create] assets/js/
    [create] assets/js/some_file.coffee
    [create] assets/css/
    [create] assets/css/some_file.scss
%
$ ls
my_awesome_app
$ ls my_awesome_app
assets  config.ru  Gemfile  my_awesome_app.rb  public  routes  spec  views
$
```

To get a list of templates you can use the `--list` flag

    $ greg --list

To install a template (mus be listed under "Available templates" on the `--list`):

    $ greg --install=<template name>

For example:

    $ greg --install=roda_app


## Installation

You can install Greg by running

    $ gem install greg

## Contributing

1. Fork it ( https://github.com/[my-github-username]/greg/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
