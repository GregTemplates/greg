module Greg
  class GemfileTemplate < FileTemplate
    attr_reader :gems

    def initialize(*gems)
      @gems = gems
    end

    def destination
      "Gemfile"
    end

    def contents
      @contents = []
      @contents << 'source "https://rubygems.org"'
      @contents << nil

      @gems.each do |gem|
        if gem.is_a?(Hash)
          gem_name, gem_options = gem.first
          r = []
          r << "gem \"#{gem_name}\""
          gem_options.each do |key, value|
            r << "#{key.to_sym}: \"#{value.to_s}\""
          end
          @contents << r.join(", ")
        else
          @contents << "gem \"#{gem}\""
        end
      end

      @contents.join("\n")
    end
  end
end
