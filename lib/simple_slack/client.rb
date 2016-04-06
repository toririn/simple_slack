require 'slack'
require 'omniauth-slack'
require 'simple_slack/getter'
require 'simple_slack/poster'

class SimpleSlack::Client
  def initialize(token)
    Slack.configure { |config| config.token = token }
    @slack = Slack.client
  end

  def get
    @getter ||= SimpleSlack::Getter.new(@slack)
  end

  def post
    @poster ||= SimpleSlack::Poster.new(@slack)
  end
end
