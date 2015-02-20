module Greg
  class FromTemplate < FileTemplate
    attr_reader :destination
    attr_reader :contents

    def initialize(destination, template)
      @destination = destination
      @contents = erb( template(template) )
    end

    def msg
      "    [create] #{destination}"
    end
  end
end
