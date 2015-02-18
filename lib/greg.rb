require "greg/version"

require "pathname"
require "fattr"

require "greg/generator"
require "greg/exceptions"

require "greg/file_template"
require "greg/dir_template"

require "greg/gemfile_template"

module Greg
  def self.generator(**options)
    @generator ||= get_generator(**options)
  end

  def self.get_generator(name:, template_name: , output_directory: ".", force: false)
    generator_name = "#{template_name}_generator"
    template = Greg.templates_dir + "/#{template_name}/#{generator_name}"
    if Pathname(template + ".rb").exist?
      require template.to_s
    else
      raise UnexistingTemplateError.new(template_name)
    end
    generator_class_name = generator_name.split("_").map(&:capitalize).join
    generator_class = Kernel.const_get(generator_class_name)
    generator_class.new( name: name,
                        template_name: template_name,
                        output_directory: output_directory,
                        force: force
                       )
  end

  def self.templates_dir
    @templates_dir ||= Pathname("~/.greg_templates").expand_path.to_s
  end

  def self.templates_dir=(new_dir)
    @templates_dir = Pathname(new_dir).expand_path.to_s
  end

end
