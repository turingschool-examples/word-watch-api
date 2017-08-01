class WordSeed
  def self.run
    Word.destroy_all
    new.seed
  end

  def seed
    add_toppings
    add_desserts
  end

  def add_toppings
    50.times do
      Faker::Dessert.topping.split(" ").each do |dessert|
        Word.create!(value: dessert) 
      end
    end
  end

  def add_desserts
    50.times do
      Faker::Dessert.variety.split(" ").each do |dessert|
        Word.create!(value: dessert) 
      end
    end
  end
end

WordSeed.run

