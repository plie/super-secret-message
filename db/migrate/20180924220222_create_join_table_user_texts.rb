class CreateJoinTableUserTexts < ActiveRecord::Migration[5.0]
  def change
  	create_table :user_texts do |t|
  		t.integer :user_id, null: false
  		t.integer :text_id, null: false
  	end

  	add_index :user_texts, :user_id
  	add_index :user_texts, :text_id
  end
end
