class ChangeWordValueToCitext < ActiveRecord::Migration[5.1]
  def change
    enable_extension("citext")
    change_column :words, :value, :citext
  end
end
