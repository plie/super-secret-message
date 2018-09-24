class CreateTexts < ActiveRecord::Migration[5.0]
  def change
    create_table :texts do |t|
    	t.string :alias
    	t.text :body
    	t.string :number, null: false
    	t.string :password_hash, null: false
    	t.string :token, unique: true, null: false

    	t.timestamps
    end
  end
end
