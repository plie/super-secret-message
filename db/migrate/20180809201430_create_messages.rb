class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :token, unique: true, null: false
      t.string :password_hash, null: false
      t.text :message_body

      t.timestamps
    end
  end
end
