require "pp"
module Greg
  class FileTreeTemplate < DefaultTemplate
    attr_reader :templates

    def initialize(templates)
      @templates ||= templates
    end

    def create!
      iterate_tree(templates) do |entry|
        puts entry.msg if entry.msg
        entry.create!
      end
    end

    def msg
      nil
    end
    
    private
    def iterate_tree(dir=".", path, &block)
      current_relative_path = Pathname([path, dir].join("/")).cleanpath
      output_path = Pathname(current_relative_path.to_s.gsub(/\A#{templates}/, ".")).cleanpath

      current_path = Pathname([
                               Greg.templates_dir,
                               Greg.generator.template_name,
                               current_relative_path
                              ].join("/"))

      (Dir.new(current_path).entries - [".", ".."]).each do |entry|
        new_name = entry.
          gsub("@APP_NAME@", Greg.generator.name).
          gsub("@TEMPLATE_NAME@", Greg.generator.template_name)
        destination = (output_path + new_name).cleanpath.to_s
        if (current_path + entry).directory?
          block.call(DirTemplate.new(destination))
          iterate_tree(entry, current_relative_path, &block)
        else
          template_name = (current_relative_path + entry).cleanpath.to_s
          block.call(FromTemplate.new(destination, template_name))
        end
      end
    end
  end
end
