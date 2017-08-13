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

  describe "querying words" do
    it "is case insensitive" do
      %w(case Case casing CASE cAsE).each { |word| create(:word, value: word) }
      expect(Word.where(value: "case").count).to eq 4
    end
  end

  describe "methods" do
    describe ".top" do
      it "returns the word with the highest frequency" do
        words = %w(ol hickory ham mike)
        words.each.with_index do |word, index|
          ((index + 1) ** 2).times do
            create(:word, value: word)
          end
        end

        expect(Word.top).to eq ({ "mike" => 16 })
      end

      it "returns an empty string if the db is empty" do
        expect(Word.top).to eq ({ "" => 0 })
      end
    end

    describe ".check_reset" do
      context "with < 1000 db records" do
        it "returns false and does nothing" do
          create_list(:word, 10, value: "something")
          create_list(:word, 989, value: "else")

          expect(Word.count).to eq 999

          output = Word.check_reset 

          expect(output).to be false
          expect(Word.count).to eq 999
        end
      end

      context "with >= 1000 db records" do
        it "returns true and leaves only the word with the highest count in the database" do
          create_list(:word, 10, value: "something")
          create_list(:word, 990, value: "else")
          expect(Word.count).to eq 1000

          output = Word.check_reset 

          expect(output).to be true
          expect(Word.count).to eq 1
          expect(Word.first.value).to eq "else"
        end
      end
    end
  end
end

