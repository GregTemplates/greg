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

## Creating you own template

The first thing you probably want to do is get some boilerplate in place:

    $ greg my_template --template=template

This will create a new directory called `my_template` under `~/.greg_templates/`.
Inside, you'll find the `my_template_generator.rb` file. That's where all the logic for the generator goes.

Now you just need to define a method called `#files`, which should return an array containing all the needed files to be created.

The easiest way to get started is using `Greg::FileTreeTemplate`, like this:

```ruby
class MyTemplateGenerator < Greg::Generator
  def files
    [
     Greg::FileTreeTemplate.new("templates"),
    ]
  end
end
```

And under `~/.greg_templates/my_template/templates/` put all the template files. This will compy the `templates` subdirectory almost verbatim to the generated application.

Notice I said "almost verbatim" and that's because we have an ace under our sleeves.
Normally, we want to name files with some name different than just 'app.rb' or 'my_app.whatever'. In that case, instead of naming the file like that, you can use the `@APP_NAME@` "variable".
If you have the following tree:

```
~/.greg_templates/foo/templates/
  ├── @APP_NAME@.rb
  └── spec
      ├── @APP_NAME@_spec.rb
      ├── @TEMPLATE_NAME@_spec.rb
      └── spec_helper.rb
```

When you run

    $ greg my_cool_app --template=foo

the resulting tree will be:

```
~/.greg_templates/foo/templates/
  ├── my_cool_app.rb
  └── spec
      ├── my_cool_app_spec.rb
      ├── foo_spec.rb
      └── spec_helper.rb
```

You also have some variables to use inside the file contents. The files will be rendered using ERB and you have the following methods available:
(assuming the app name is again `my_cool_app`)

| variable      | exported value |
| ------------- |:--------------:| 
| app_name      | my_cool_app    | 
| app_clas_name | MyCoolApp      | 

## Installation

You can install Greg by running

    $ gem install greg

## Contributing

1. Fork it ( https://github.com/[my-github-username]/greg/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
