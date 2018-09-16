class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
    	t.string :cell, null: false
    	t.string :password_hash, null: false

    	t.timestamps
    end
  end
end
