class SimpleSlack::Poster
  def initialize(slack, simple_slack)
    @slack = slack
    @simple_slack = simple_slack
  end

  def channels(to: , text: , name: "slacker", **options)
    to.all? do |t|
      id = convert_channel_to_id(t.to_s)
      send_chat({ username: name, channel: id, text: text }.merge(options))
    end
  end

  def channel(to: , text: , name: "slacker", **options)
    id = convert_channel_to_id(to.to_s)
    send_chat({ username: name, channel: id, text: text }.merge(options))
  end

  def user(to: , text: , name: "slacker")
    "yet"
  end

  def chat(channel: nil, user: nil, text: , name: "slacker", **options)
    if channel
      self.channel({ to: channel, text: text, name: name }.merge(options))
    elsif user
      "yet"
    end
  end

  def ims(to: , text: , name: "slacker", **options)
    to.all? do |t|
      id = convert_im_to_id(t.to_s)
      send_chat({ username: name, channel: id, text: text }.merge(options))
    end
  end

  def im(to: , text: , name: "slacker", **options)
    id = convert_im_to_id(to.to_s)
    send_chat({ username: name, channel: id, text: text }.merge(options))
  end

  private

  def send_chat(username: , channel: , text: , icon_emoji: ":ghost:", **options)
    result = @slack.chat_postMessage({ username: username, channel: channel, text: text, icon_emoji: icon_emoji }.merge(options))
    result["ok"]
  end

  def convert_channel_to_id(key)
    channel = @simple_slack.get.channel(key)
    if channel
      channel[:id]
    else
      raise "チャンネルが見つかりませんでした。"
    end
  end

  def convert_im_to_id(key)
    im = @simple_slack.get.im(key)
    if im
      im[:id]
    else
      raise "IMが見つかりませんでした。"
    end
  end
end
