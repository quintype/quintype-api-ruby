describe Quintype::API::Story do
  describe 'find_by_slug' , :vcr => { cassette_name: "api_story_find_by_slug" } do
    it 'finds the story by slug' do
      story = Quintype::API::Story.find_by_slug("the-greatest")
      expect(story.id).to eq("1d2fc836-4113-4ae1-8735-377167664892")
    end
  end
end
