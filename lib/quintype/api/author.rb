module Quintype::API
  class Author < Base(%w(id name slug email avatar-url avatar-s3-key twitter-handle))
    class << self
      def get(author_id)
        Client.instance.get_author(author_id).to_h
      end
    end
  end
end
