# load auths
app_conf = YAML.load_file(Rails.root.join('config', 'auths.yml'))

# Override config options by correct environment
env_options = app_conf.delete(Rails.env)

app_conf.merge!(env_options) unless env_options.nil?

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, app_conf['facebook_api_key'], app_conf['facebook_api_secret']
  provider :twitter, app_conf['t_consumer_key'], app_conf['t_consumer_secret']
end
