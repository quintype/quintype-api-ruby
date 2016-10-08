module Quintype::API
  class Bulk
    def initialize
      @requests = {}
    end

    def add_request(name, request)
      @requests[name] = request
      self
    end

    def execute!
      requests = @requests.inject({}) do |acc, pair|
        acc[pair[0]] = pair[1].to_bulk_request
        acc
      end
      response = Client.instance.post_bulk(requests)
      @responses = response.inject({}) do |acc, pair|
        acc[pair[0]] = @requests[pair[0]].from_bulk_response(pair[1])
        acc
      end
    end

    def get_response(name)
      @responses[name]
    end

    def cache_keys(opts = {})
      @responses.values.flat_map { |response| response.respond_to?(:cache_keys) ? response.cache_keys(opts) : []  }
    end
  end
end
