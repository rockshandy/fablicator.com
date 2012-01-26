class RenameUserIdToAdminUserIdInPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :user_id, :admin_user_id
  end
end
