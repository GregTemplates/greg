module Greg
  class DirTemplate
    attr_reader :destination
    attr_accessor :generator

    def initialize(destination)
      @destination = destination
    end

    def create!
      generator.inside_dir do
        new_dir = Pathname(destination).expand_path
        new_dir.mkdir unless new_dir.exist?
      end
    end
  end
end
