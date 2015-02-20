require "erb"

module Greg
  class FileTemplate < DefaultTemplate
    attribute :destination
    attribute :contents
    def create!
      Greg.generator.inside_dir do
        current_file = Pathname(destination).expand_path
        current_file.dirname.mkdir unless current_file.dirname.exist?
        current_file.write(contents)
      end
    end

    def msg
      "    [create] #{destination}"
    end

    private

    def template(file)
      Pathname(generator.template_dir + "/" + file).expand_path.read
    end

    def erb(str)
      ERB.new(str).result(instance_eval { binding })
    end
  end
end
