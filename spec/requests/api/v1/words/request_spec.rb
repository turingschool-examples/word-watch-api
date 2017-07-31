require "rails_helper"

RSpec.describe "Word resource API" do
  describe "POST /api/v1/words" do
    describe "given good data" do
      let(:data) { { word: { value: "hickory" } } }

      it "returns a 201" do
        expect(Word.count).to eq 0

        post api_v1_words_path, params: data

        expect(response).to be_success
        expect(response.status).to eq 201
      end

      it "adds a word to the database" do
        expect(Word.count).to eq 0
        post api_v1_words_path, params: data
        expect(Word.count).to eq 1
        expect(Word.last.value).to eq "hickory"
      end
    end

    describe "given bad data" do
      let(:data) { { word: { value: "hickory10" } } }

      it "returns a 422 and error message" do
        post api_v1_words_path, params: data

        expect(response).to_not be_success
        expect(response.status).to eq 422

        error = JSON.parse(response.body, symbolize_names: true)
        expect(error[:message]).to eq "Value only allows letters"
      end

      it "does not add a word to the database" do
        expect(Word.count).to eq 0

        post api_v1_words_path, params: data

        expect(Word.count).to eq 0
      end
    end
  end
end

