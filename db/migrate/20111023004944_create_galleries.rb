class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :title, :picasa_album
      t.timestamps
    end
  end
end

