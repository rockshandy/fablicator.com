class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_update_at

      t.timestamps
    end
  end
end
