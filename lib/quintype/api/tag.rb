module Quintype::API
  class Tag < Base(%w(name meta-description))

    def initialize(config, *args)
      @config = config
      super(*args)
    end

    class << self

      def find_by_name(name)
        response = Client.instance.get_tag_by_name(name)
        from_hash(response) if response
      end

    end

  end
end
