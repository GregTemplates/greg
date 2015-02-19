module Greg
  class DirTemplate < DefaultTemplate
    attr_reader :destination
    def initialize(destination)
      @destination = destination
    end

    def create!
      generator.inside_dir do
        new_dir = Pathname(destination).expand_path
        new_dir.mkdir unless new_dir.exist?
      end
    end

    def to_s
      "#{destination}/"
    end
  end
end
