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
      if ENV['os'] == "Windows_NT"
        output_dir = "#{templates_dir}\\#{template}"
        `rmdir /s /q #{output_dir}`
        command = %W[git clone https://github.com/GregTemplates/#{template}.git #{output_dir}] 
      else
        output_dir = "#{templates_dir}/#{template}"
        `rm -rf #{output_dir}`
        command = %W[git clone git@github.com:GregTemplates/#{template}.git #{output_dir}]
      end
      puts command.join " "
      IO.popen(command) do |out|
        out.read.each_line {|l| puts l}
      end
    end
  end
end
