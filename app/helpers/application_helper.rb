module ApplicationHelper
  def provider_img(p)
    image_tag "#{p}_login.png"
  end
  
  def provider_link(p)
    link_to provider_img(p), "/auth/#{p}"
  end
end
