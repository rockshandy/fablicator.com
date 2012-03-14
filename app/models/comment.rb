class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :author, :class_name => 'User', :foreign_key=> 'user_id'
  
  validates :body, :presence => true
  validates :author, :presence => {:message => "Please login before commenting!"}
  
  # TODO: debate making concept of replies, where admin can respond to a user or
  #       have polymorphic relation to let admins also make comments
end
