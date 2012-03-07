# load auths
app_conf = YAML.load_file(Rails.root.join('config', 'auths.yml'))

# Override config options by correct environment
env_options = app_conf.delete(Rails.env)

app_conf.merge!(env_options) unless env_options.nil?

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, app_conf['facebook_api_key'], app_conf['facebook_api_secret']
  provider :twitter, app_conf['t_consumer_key'], app_conf['t_consumer_secret']
  # If you don't need a refresh token -- if you're only using Google for account creation/auth and don't need google services -- set the access_type to 'online'.
  # Also, set the approval prompt to an empty string, since otherwise it will be set to 'force', which makes users manually approve to the Oauth every time they log in.
  # See http://googleappsdeveloper.blogspot.com/2011/10/upcoming-changes-to-oauth-20-endpoint.html
  provider :google_oauth2, app_conf['g_key'], app_conf['g_secret'], {:access_type=>'online', :approval_prompt=> ''}
end
