class AddForeignKeyToTexts < ActiveRecord::Migration[5.0]
  def change
  	add_foreign_key :texts, :user
  end
end
