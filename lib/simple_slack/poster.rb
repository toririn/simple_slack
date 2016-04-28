class SimpleSlack::Poster
  def initialize(slack, simple_slack)
    @slack = slack
    @simple_slack = simple_slack
  end

  def channel(to: , text: , name: "slacker")
    to.to_s =~ /\AC0.{7}\Z/ ?  id = to : id = convert_channel(to)
    send_chat(username: name, channel: id, text: text)
  end

  def user(to: , text: , name: "slacker")
    "yet"
  end

  def chat(channel: nil, user: nil, text: , name: "slacker")
    if channel
      self.channel(to: channel, text: text, name: name)
    elsif user
      "yet"
    end
  end

  def im(to: , text: , name: "slacker")
    to.to_s =~ /\AD0.{7}\Z/ ?  id = to : id = convert_im(to)
    send_chat(username: name, channel: id, text: text)
  end

  private

  def send_chat(username: , channel: , text: , icon_emoji: ":ghost:")
    result = @slack.chat_postMessage(username: username, channel: channel, text: text, icon_emoji: icon_emoji)
    result["ok"]
  end

  def convert_channel(name)
    channel = @simple_slack.get.channel(name)
    channel[:id]
  end

  def convert_im(name)
    im = @simple_slack.get.im(name)
    im[:id]
  end
end
