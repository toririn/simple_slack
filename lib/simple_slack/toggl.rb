require 'togglv8'
require "simple_slack/toggls/toggl_parameter"
require "simple_slack/toggls/toggl_dailyreport"
require "simple_slack/toggls/toggl_dailyreport"
class SimpleSlack::Toggl
  include TogglParameter
  include TogglDailyreport

  attr_accessor :toggl_client, :simple_client, :post_channels, :post_bot_name, :post_bot_image, :post_ims

  URL       = "https://toggl.com/"
  TIMER_URL = "#{URL}app/timer"

  def initialize(toggl_api_token, simple_slack_client)
    @toggl_client   = TogglV8::API.new(toggl_api_token)
    @simple_client  = simple_slack_client
    @post_bot_name  = "slacker"
    @post_bot_image = ":joy:"
    @post_channels  = []
    @post_ims       = []
  end

  def configure
    yield self
  end

  def post_message(type = :regular)
    case type.to_s
    when "morning"
      post_message_by(send_morning_message)
    when "regular"
      post_message_by(send_regular_message)
    when "noon"
      post_message_by(send_noon_message)
    when "after_noon"
      post_message_by(send_after_noon_message)
    when "night"
      post_message_by(send_night_message)
    when "dailyreport"
      post_message_by(send_dailyreport_message)
    end
  end

  private

  def post_message_by(text)
    if post_channels.empty? && post_ims.empty?
      raise "メッセージの送り先チャンネル、IMが指定されていません"
    end
    simple_client.post.channels(to: post_channels, text: text, name: post_bot_name, icon_emoji: post_bot_image) unless post_channels.empty?
    simple_client.post.ims(to: post_ims, text: text, name: post_bot_name, icon_emoji: post_bot_image)           unless post_ims.empty?
    text
  end

end

