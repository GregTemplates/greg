module Greg
  class TemplateInstaller
    attr_reader :template
    attr_reader :templates_dir
    def initialize(template:, templates_dir: Greg.templates_dir)
      raise "greg is not a template" if template == "greg"
      @template      = template
      @templates_dir = templates_dir
    end
    def install
      output_dir = "#{templates_dir}/#{template}"
      `rm -rf #{output_dir}`
      command = %W[git clone git@github.com:GregTemplates/#{template}.git #{output_dir}]
      puts command.join " "
      IO.popen(command) do |out|
        out.read.each_line {|l| puts l}
      end
    end
  end
end
