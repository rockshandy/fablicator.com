class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :subscribed, :default => false
      t.timestamps
    end
  end
end
