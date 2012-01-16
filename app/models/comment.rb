class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :author, :class_name => 'User', :foreign_key=> 'user_id'
  
  validates :title, :presence => true
  validates :body, :presence => true
  validates :author, :presence => {:message => "Please login before commenting!"}
end
