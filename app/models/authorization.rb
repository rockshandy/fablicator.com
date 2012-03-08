class Authorization < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider
  
  PROVIDERS = %w(facebook twitter google_oauth2)

  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.create_from_hash(hash, user = nil, rand = Time.now.to_f)
    user ||= User.create_from_hash!(hash, rand)
    if user.errors.size > 0
      false
    else
      Authorization.create(:user => user, :uid => hash['uid'], :provider => hash['provider'])
    end
  end
  
  def self.providers
    PROVIDERS
  end
end
