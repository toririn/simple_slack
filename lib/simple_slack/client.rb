require 'slack'
require 'simple_slack/getter'
require 'simple_slack/poster'
require 'simple_slack/botter'

class SimpleSlack::Client
  def initialize(token)
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
end
