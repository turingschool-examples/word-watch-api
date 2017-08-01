class Word < ApplicationRecord
  validates :value, presence: true,
    format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }

  def self.top
    { top_word => top_word_count }
  end

  private

  def self.top_word
    select("words.value, count(words.value) as word_count")
      .group(:value)
      .order("word_count DESC")
      .first
      .value
      .downcase rescue ""
  end

  def self.top_word_count
    return 0 if top_word == ""
    where(value: top_word).count
  end
end
