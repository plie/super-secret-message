class AddHandleToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :handle, :string, null: :false
  end
end
