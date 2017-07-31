require 'rails_helper'

RSpec.describe Word, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:value) }
    it "is expected to validate only alphabet values" do
      word = Word.new(value: "1a")
      expect(word).to be_invalid
      expect(word.errors.messages.values.join(", ")).to eq "only allows letters"
    end
  end
end

