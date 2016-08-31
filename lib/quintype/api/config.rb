module Quintype::API
  class Config < Base(%w(sketches-host sections layout cdn-name publisher-id story-slug-format cdn-image social-links seo-metadata))
    class << self
      def get
        from_hash(Client.instance.get_config)
      end
    end

    coerce_array :sections, Section

    def menu_items
      layout["menu"].map { |i| MenuItem.from_hash(i, self) }
    end

    def stacks
      StackCollection.new layout["stacks"].map { |i| Stack.from_hash(i) }
    end
  end
end
