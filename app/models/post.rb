class Post < ActiveRecord::Base
  belongs_to :author, :class_name => "AdminUser", :foreign_key=> 'admin_user_id'
  has_many :comments, :dependent => :destroy
  
  scope :published, lambda { 
    where("posts.created_at IS NOT NULL AND posts.publish = true")
  }
  
  scope :recent, lambda {|num| published.order("posts.created_at DESC").limit(num)}
  scope :drafts, where(:publish => false)
  
  # TODO: think about including first image as well in a thumbnail
  # look into image magick
  # returns the first part of a post to a passed in HTML tag
  # can take an array of tags or regex to try
  # defaults to paragraph followed by a new line
  def summary(tries=["</p>","\n"])
    m = nil
    i = 0
    # won't worry about i, upon another iteration an above index array returns nil
    # which in the regex just matches an empty string, ending the loop
    until m != nil
      m = content.match(/.*?#{tries[i]}/)
      i+=1
    end
    m[0].html_safe if m
  end
end
