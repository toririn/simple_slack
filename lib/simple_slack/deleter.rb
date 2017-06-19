module SimpleSlack
  class Deleter
    def initialize(slack, client)
      @slack  = slack
      @client = client
    end

    def to_a
      "#chat(ts: string:require, channel: string:require. as_user: boolean:optional)"
    end

    def chat(channel:, ts:, as_user: true)
      channel_id = @client.get.channel(channel)[:id]
      @slack.chat_delete(channel: channel_id, ts: ts, as_user: as_user)
    end
  end
end
