require "rails_helper"

RSpec.describe "Top word resource API" do
  describe "GET /api/v1/top_word" do
    it "returns a 200" do
      get api_v1_top_word_path

      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it "returns the word downcased with the highest count" do
      words = %w(Mike ol hickory ham mike)
      words.each.with_index do |word, index|
        ((index + 1) ** 2).times do
          create(:word, value: word)
        end
      end

      get api_v1_top_word_path
      
      word = JSON.parse(response.body, symbolize_names: true)
      expect(word[:value]).to eq "mike"
    end
  end
end

