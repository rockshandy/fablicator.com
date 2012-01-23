class AddMoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :display_name, :string
    add_column :users, :email, :string
  end
end
