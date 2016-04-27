class SimpleSlack::Poster
  def initialize(slack)
    @slack = slack
  end

  def channel(to: , text: , name: "slacker")
    to.to_s =~ /\AC0.{7}\Z/ ?  id = to : id = convert(to)
    result = @slack.chat_postMessage(username: name, channel: id, text: text)
    result["ok"]
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

  private

  def convert(name)
    channel = @slack.get.channel(name)
    channel[:id]
  end
end
