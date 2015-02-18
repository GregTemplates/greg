module Greg
  class UnexistingTemplateError < Exception
    attr_reader :template
    def initialize(template)
      @template = template
    end
  end

  class ExistingProjectError < Exception
    attr_reader :dir
    def initialize(dir)
      @dir = dir
    end
  end
end
