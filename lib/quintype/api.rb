require "quintype/api/version"

require "faraday"
require "faraday_middleware"

module Quintype
  module API
    autoload :Client,           "quintype/api/client"
    autoload :BaseFunctions,    "quintype/api/base_functions"

    def self.Base(*args)
      clazz = Struct.new(*args)
      clazz.send(:include, BaseFunctions)
      clazz
    end

    autoload :Config,           "quintype/api/config"
    autoload :Section,          "quintype/api/section"
    autoload :MenuItem,         "quintype/api/menu_item"
    autoload :Stack,            "quintype/api/stack"
    autoload :StackCollection,  "quintype/api/stack_collection"
    autoload :Story,            "quintype/api/story"
    autoload :Bulk,             "quintype/api/bulk"
  end
end
