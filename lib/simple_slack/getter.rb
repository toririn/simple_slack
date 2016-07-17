class SimpleSlack::Getter
  def initialize(slack)
    @slack = slack
  end

  # use options for
  # :is_channel, :creator, :members, :topic, :purpose, :num_members, etc
  def channels(options = [])
    channels = @slack.channels_list
    channels["channels"].map do |channel|
      add_params = options.empty? ?  {} : options_to_hash(options, channel)
      { id: channel["id"], name: channel["name"] }.merge(add_params)
    end.sort_by {|ch| ch[:name] }
  end

  def channel(key, options = [])
    key.to_s =~ /\AC.{8}\Z/ ? key_id = key : key_name = key
    channel_list = channels(options)
    if key_id
      channel_list.find{|ch| ch[:id]   == key_id   }
    elsif key_name
      channel_list.find{|ch| ch[:name] == key_name }
    end
  end

  # use options for
  # :real_name, :is_admin, :is_bot, etc...
  def users(options = [])
    users = @slack.users_list
    users["members"].map do |user|
      add_params = options.empty? ? {} : options_to_hash(options, user)
      { id: user["id"], name: user["name"] }.merge(add_params)
    end.sort_by {|ch| ch[:name] }
  end

  def user(key, options = [])
    key.to_s =~ /\AU.{8}\Z/ ? key_id = key : key_name = key
    user_list = users(options)
    if key_id
      user_list.find{|user| user[:id]   == key_id }
    elsif key_name
      user_list.find{|user| user[:name] == key_name }
    end
  end

  # use options for
  # :image_24, :image_32, :image_48, image_72, etc...
  def images(options = [])
    users = @slack.users_list
    users["members"].map do |user|
      add_params = options.empty? ? {} : options_to_hash(options, user["profile"])
      { id: user["id"], name: user["name"], image: user["profile"]["image_24"] }.merge(add_params)
    end
  end

  def image(key, options = [])
    key.to_s =~ /\AU.{8}\Z/ ? key_id = key : key_name = key
    image_list = images(options)
    if key_id
      image_list.find{|user| user[:id]   == key_id }
    elsif key_name
      image_list.find{|user| user[:name] == key_name }
    end
  end

  # use options for
  # :created, :is_im, :is_org_shared, :is_user_deleted
  def ims(options = [])
    im_list = @slack.im_list
    im_list["ims"].map do |im|
      im_user = if im["user"] == "USLACKBOT"
                  { id: im["user"], name: "slackbot" }
                else
                  user(im["user"])
                end
      add_params = options.empty? ? {} : options_to_hash(options, im)
      { id: im["id"], user: im_user }.merge(add_params)
    end
  end

  def im(key, options = [])
    key.to_s =~ /\AU.{8}\Z/ ? key_id = key : key_name = key
    im_list = ims(options)
    if key_id
      im_list.find{|im| im[:user][:id]   == key_id }
    elsif key_name
      im_list.find{|im| im[:user][:name] == key_name }
    end
  end

  def chats
    "yet"
  end

  def chat
    "yet"
  end

  private

  def options_to_hash(options, type = {})
    marged_option = {}
    options.each do |op|
      marged_option.merge!({ op.to_sym => type[op.to_s] })
    end

    marged_option
  end


end
