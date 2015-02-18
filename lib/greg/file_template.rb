require "erb"

module Greg
  class FileTemplate
    attr_accessor :generator
    def create!
      generator.inside_dir do
        current_file = Pathname(destination).expand_path
        current_file.dirname.mkdir unless current_file.dirname.exist?
        current_file.write(contents)
      end
    end

    private

    def initialize(**attrs)
      attrs.each do |attr, value|
        send attr, value
      end
    end

    def self.attribute(attr)
      fattr attr
    end
    private_class_method :attribute

    def template(file)
      Pathname(generator.template_dir + "/" + file).expand_path.read
    end

    def erb(str)
      ERB.new(str).result(instance_eval { binding })
    end
  end
end
