class Post < ActiveRecord::Base
  belongs_to :author, :class_name => "AdminUser", :foreign_key=> 'admin_user_id'
  has_many :comments, :dependent => :destroy
  
  scope :published, lambda { 
    where("posts.created_at IS NOT NULL AND posts.created_at <= ?", Time.zone.now)
  }
  
  scope :recent, lambda {|num| published.order("posts.created_at DESC").limit(num)}
end
