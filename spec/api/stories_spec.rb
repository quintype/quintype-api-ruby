describe Quintype::API::Story do
  describe 'find_by_slug' , vcr: { cassette_name: "api_story_find_by_slug" } do
    it 'finds the story by slug' do
      story = Quintype::API::Story.find_by_slug("the-greatest")
      expect(story.id).to eq("1d2fc836-4113-4ae1-8735-377167664892")
    end
  end

  describe "finding a story group", vcr: { cassette_name: "api_stories" } do
    it "finds the top stories" do
      stories = Quintype::API::Story.fetch("top")
      expect(stories.take(4).map(&:id)).to eq(["2e30cea1-b063-4531-9cbd-4f8631e55f60", "74630f9d-7a10-4531-beea-3bc79237af9b", "78009fc6-51c4-4f4f-8e7c-46fcb2bafe6b", "21301745-78d1-4c9a-bdf8-c56377f7c0de"])
    end

    describe "caching keys" do
      it "fetches the correct keys for all stories" do
        stories = Quintype::API::Story.fetch("top")
        expect(stories.cache_keys(publisher_id: 15).take(5)).to eq(["q/15/top/home", "s/15/2e30cea1", "s/15/74630f9d", "s/15/78009fc6", "s/15/21301745"])
      end

      it "can mark stories for soft purging" do
        stories = Quintype::API::Story.fetch("top")
        expect(stories.cache_keys(publisher_id: 15, soft: "all").take(5)).to eq(["sq/15/top/home", "ss/15/2e30cea1", "ss/15/74630f9d", "ss/15/78009fc6", "ss/15/21301745"])
      end
    end
  end
end
