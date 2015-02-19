module Greg
  class Generator
    attr_reader :name
    attr_reader :template_name
    attr_reader :template_path
    attr_reader :output_directory
    attr_reader :current_dir
    attr_reader :force
    attr_reader :generator

    def initialize(name:, template_name: , output_directory: ".", force: false)
      @name = name
      @template_name = template_name
      @output_directory = Pathname(output_directory + "/" + name).expand_path
      @current_dir = Pathname(".").expand_path

      @force = force
    end

    def run
      create_directory
      create_files
      self
    end

    def files
      []
    end

    def inside_dir(&block)
      Dir.chdir(output_directory, &block)
    end

    def template_dir
      Pathname(Greg.templates_dir + "/" +  template_name).expand_path.to_s
    end

    private

    def create_files
      puts "Creating Project:"
      files.each do |file|
        puts "  [create] ./#{file}"
        file.create!
      end
    end

    def create_directory
      if output_directory.exist?
        if force
          puts "#{output_directory + template_name} exists, removing it.\n\n"
          output_directory.rmtree
        else
          raise ExistingProjectError.new(output_directory + template_name)
        end
      end
      output_directory.mkpath
    end
  end
end
