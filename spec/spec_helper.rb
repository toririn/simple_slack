$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
SIMPLE_SLACK_API_TOKEN = ENV['GEM_SIMPLE_SLACK_API_TOKEN']
require 'simple_slack'

RSpec.configure do |config|
  config.before :each do
    sleep 3
  end
end
