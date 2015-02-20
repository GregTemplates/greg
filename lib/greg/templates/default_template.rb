module Greg
  class DefaultTemplate
    def app_name
      generator.name
    end

    def app_class_name
      @template_class_name ||= generator.name.split("_").map(&:capitalize).join
    end

    private

    def initialize(**attrs)
      attrs.each do |attr, value|
        send attr, value
      end
    end

    def generator
      Greg.generator
    end
    
    def self.attribute(attr)
      fattr attr
    end
    private_class_method :attribute

  end
end
