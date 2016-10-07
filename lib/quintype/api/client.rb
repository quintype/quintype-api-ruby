module Quintype::API
  class ClientException < Exception
    attr_reader :response

    def initialize(message, response)
      super(message)
      @response = response
    end
  end

  class Client
    class << self
      def establish_connection(host, adapter = nil)
        connection = Faraday.new(host) do |conn|
          conn.request  :json
          conn.response :json, :content_type => /\bjson$/
          conn.adapter(adapter || Faraday.default_adapter)
        end
        @client = new(connection)
      end

      def instance
        @client
      end
    end

    def initialize(conn)
      @conn = conn
    end

    def get_config
      response = get("/api/v1/config")
      raise ClientException.new("Could not get config", response) unless response.status == 200
      response.body
    end

    def get_story_by_slug(slug)
      response = get("/api/v1/stories-by-slug", slug: slug)
      return nil if response.status == 404
      raise ClientException.new("Could not fetch story", response) unless response.status == 200
      response.body["story"]
    end

    def get_stories(params)
      response = get("/api/v1/stories", params)
      raise ClientException.new("Could not get stories", response) unless response.status == 200
      response.body["stories"]
    end

    def get_search(params)
      response = get("/api/v1/search", params)
      raise ClientException.new("Could not search stories", response) unless response.status == 200
      response.body["results"]
    end

    def get_author(author_id)
      response = get("/api/v1/authors/" + author_id)
      raise ClientException.new("Could not get authors", response) unless response.status == 200
      response.body["author"]
    end

    def post_bulk(requests)
      response = post("/api/v1/bulk", requests: requests)
      raise ClientException.new("Could not bulk fetch", response) unless response.status == 200
      response.body["results"]
    end

    private
    def get(url, params = {})
      @conn.get(url, params)
    end

    def post(url, body, params = {})
      @conn.post(url, body, params)
    end
  end
end
