class SimpleSlack::Botter
  def initialize(token, client)
    Slack.configure {|c| c.token = token }
    @r_client = Slack.realtime
    @client   = client
    @channel, @text, @user = ["all"] * 3
    @responce_channel, @responce_text, @responce_user = nil, nil, "slacker"
  end

  def set_condition(channel: nil, text: nil, user: nil)
    @channel = set_condition_channel(channel) if channel
    @user    = set_condition_user(user)       if user
    @text    = set_condition_text(text)       if text
    { channel: @channel, user: @user, text: @text }
  end

  def set_responce(channel: nil , text: nil, user: nil)
    @responce_channel = channel  if channel
    @responce_text    = text     if text
    @responce_user    = user     if user
    if block_given?
      @responce_block = Proc.new(&yield)
    end
    { channel: @responce_channel, user: @responce_user, text: @responce_text }
  end

  def status
    variables = instance_variables.map {|v| v.to_s }
    variables.map {|v| { v.to_s => instance_variable_get(v) } }
  end

  def start
    return p "not set params. need set_responce(channel: , text: , user: )" unless valid_params
    @r_client.on :message do |data|
      if fit_condition?(data)
        send_responce(data)
      end
    end
    puts "client start!"
    @r_client.start
  end

  private

  def send_responce(data)
    if @responce_block.nil?
      @client.post.channel(to: @responce_channel, text: @responce_text, name: @responce_user)
    else
      responce = {}.tap do |res|
        res[:user]    = @client.get.user(data["user"])[:name] rescue "unknown"
        res[:channel] = @client.get.channel(data["channel"])[:name] rescue "unknown"
        res[:text]    = data["text"]
      end
      @responce_block.call(data, responce)
    end
  end

  def fit_condition?(data)
    fit_params?(@channel, data["channel"]) && fit_params?(@user, data["user"]) && fit_params?(@text, data["text"])
  end

  def fit_params?(set_params, res_param)
    return true if set_params == "all"
    case set_params
    when String
      set_params == res_param
    when Array
      set_params.any? {|param| fit_params?(param, res_param) }
    when Regexp
      set_params =~ res_param
    when Hash
      set_params[:id] == res_param
    else
      false
    end
  end

  def set_condition_channel(channel)
    return nil   if channel.nil?
    return "all" if channel.to_s == "all" rescue false
    case channel
    when String
      @client.get.channel(channel)
    when Array
      channel.map {|ch| @client.get.channel(ch.to_s) }
    when Hash
      channel
    when Symbol
      @client.get.channel(channel.to_s)
    else
      "error: invalid Object"
    end
  end

  def set_condition_user(user)
    return nil   if user.nil?
    return "all" if user.to_s == "all" rescue false
    case user
    when String
      @client.get.user(user)
    when Array
      user.map {|u| set_condition_user(u) }
    when Hash
      user
    when Symbol
      @client.get.user(user.to_s)
    else
      "error: invalid Object"
    end
  end

  def set_condition_text(text)
    return nil   if text.nil?
    return "all" if text.to_s == "all" rescue false
    case text
    when String
      text.gsub(/\p{blank}/,"\s").strip.split("\s")
    when Array
      text.map {|t| set_condition_text(t) }
    when Regexp
      text
    else
      text.to_s rescue nil
    end
  end

  def set_responce_channel(channel)
    set_condition_channel(channel)
  end

  def valid_params
    return true if @responce_block
    variables = ["@responce_channel", "@responce_text"]
    variables.none? {|v| instance_variable_get(v).nil? }
  end

end
