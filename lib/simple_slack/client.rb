require 'slack'
require 'simple_slack/getter'
require 'simple_slack/poster'
require 'simple_slack/botter'
require 'simple_slack/deleter'
require 'simple_slack/toggl'

module SimpleSlack
  class Client
    def initialize(token = ENV['SLACK_API_TOKEN'])
      @token = token
      Slack.configure { |config| config.token = @token }
      @slack = Slack.client
    end

    def get
      @getter ||= SimpleSlack::Getter.new(@slack)
    end

    def post
      @poster ||= SimpleSlack::Poster.new(@slack, self)
    end

    def bot
      @botter ||= SimpleSlack::Botter.new(@token, self)
    end

    def delete
      @delete ||= SimpleSlack::Deleter.new(@slack, self)
    end

    def toggl(toggl_api_token = ENV['TOGGL_API_TOKEN'])
      @toggl  ||= SimpleSlack::Toggl.new(toggl_api_token, self)
    end
  end
end
