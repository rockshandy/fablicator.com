class User < ActiveRecord::Base
  has_many :authorizations
  has_many :comments

  def self.create_from_hash!(hash)
    create(:name => hash['info']['name'])
  end
  
  # TODO: need to address profile picture issues at some point
end
