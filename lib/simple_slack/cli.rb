require 'thor'
require "simple_slack/client"

module SimpleSlack
  class CLI < Thor
    desc 'post channel', 'post channel to channel_name'
    def post(channel, text)
      client = SimpleSlack::Client.new
      client.post.channel(to: channel, text: text)
    end

    desc 'post channel rspec', 'post channel to rspec results'
    def rspec(file_name = 'spec/', channel = nil, bundle = true)
      return 'channel name blank' if channel.nil?
      client = SimpleSlack::Client.new
      if bundle
        text = `bundle exec rspec #{file_name}`
      else
        text = `rspec #{file_name}`
      end
      puts text
      client.post.channel(to: channel, text: text)
    end
  end
end
