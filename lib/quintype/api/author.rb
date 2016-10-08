module Quintype::API
  class Author < Base(%w(id name slug email avatar-url avatar-s3-key twitter-handle))
    class << self
      def find(id)
        from_hash Client.instance.get_author(id).to_h
      end
    end
  end
end
