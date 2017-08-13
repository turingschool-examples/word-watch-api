class Word < ApplicationRecord
  validates :value, presence: true,
    format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }

  def self.top
    { top_word => top_word_count }
  end

  def self.check_reset
    database_actions[Word.count >= 1000].call()
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

  def self.database_actions
    {
      false => -> { false },
      true  => reset
    }
  end

  def self.reset
    -> do
      word = find_by(value: top_word) 
      where.not(id: word.id).destroy_all
      true
    end
  end
end
