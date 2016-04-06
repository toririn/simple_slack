class SimpleSlack::Getter
  def initialize(slack)
    @slack = slack
  end

  def channels
    channels = @slack.channels_list
    channels["channels"].map do |channel|
      { id: channel["id"], name: channel["name"] }
    end.sort_by {|ch| ch[:name] }
  end

  def channel(key)
    key.to_s =~ /\AC0.{7}\Z/ ? key_id = key : key_name = key
    @channel_list ||= channels
    if key_id
      @channel_list.find{|ch| ch[:id]   == key_id   }
    elsif key_name
      @channel_list.find{|ch| ch[:name] == key_name }
    else
      "not found"
    end
  end

  def users
    users = @slack.users_list
    users["members"].map do |user|
      { id: user["id"], name: user["name"] }
    end.sort_by {|ch| ch[:name] }
  end

  def user(key)
    key.to_s =~ /\AU0.{7}\Z/ ? key_id = key : key_name = key
    @user_list ||= users
    if key_id
      @user_list.find{|user| user[:id]   == key_id }
    elsif key_name
      @user_list.find{|user| user[:name] == key_name }
    else
      "not found"
    end
  end

  def images
    image_list = users["members"].map do |user|
      { id: user["id"], image: user["profile"]["image_24"] }
    end
  end

  def image(id)
    @image_list ||= images
    @image_list.find{|user| user[:id] == id }
  end

  def chats
    "yet"
  end

  def chat
    "yet"
  end
end
