Gem.clear_paths
require 'rubygems'
# Set up gems listed in the Gemfile.
if File.exist?(File.expand_path('../../Gemfile', __FILE__))
  require 'bundler'
  Bundler.setup
end

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
FablicatorCom::Application.initialize!

