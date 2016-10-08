describe Quintype::API::Bulk do
  describe "finding a story group", vcr: { cassette_name: "bulk_api" } do
    it "finds the top stories" do
      request = Quintype::API::Bulk.new
      request.add_request("top", Quintype::API::Story.bulk_stories_request("top"))
      request.execute!
      expect(request.get_response("top").take(4).map(&:id)).to eq(["2e30cea1-b063-4531-9cbd-4f8631e55f60", "74630f9d-7a10-4531-beea-3bc79237af9b", "78009fc6-51c4-4f4f-8e7c-46fcb2bafe6b", "21301745-78d1-4c9a-bdf8-c56377f7c0de"])
    end

    describe "caching keys" do
      it "fetches the correct keys for all stories" do
        request = Quintype::API::Bulk.new
        request.add_request("top", Quintype::API::Story.bulk_stories_request("top"))
        request.execute!
        expect(request.cache_keys(publisher_id: 15).take(5)).to eq(["q/15/top/home", "s/15/2e30cea1", "s/15/74630f9d", "s/15/78009fc6", "s/15/21301745"])
      end
    end
  end
end
