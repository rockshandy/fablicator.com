class User < ActiveRecord::Base
  has_many :authorizations, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  validates :display_name, :presence => true, :uniqueness => true
  
  def self.create_from_hash!(hash,rand = Time.now.to_f)
    name = hash['info']['name']
    parts = name.split(/\s/)
    display = "#{parts[0]} #{parts[-1][0,1]}."
    u = create(:name => name, :display_name => display)
    if u.errors.size > 0
      u = create(:name => name, :display_name => display + rand.to_s)
    end
    u
  end
  
  # TODO: need to address profile picture issues at some point (gravatar?)
end
