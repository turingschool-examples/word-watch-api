class Word < ApplicationRecord
  validates :value, presence: true,
    format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }

  def self.top
    select("words.value, count(words.value) as word_count")
      .group(:value)
      .order("word_count DESC")
      .first
      .value
      .downcase rescue ""
  end
end
