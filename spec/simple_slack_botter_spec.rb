require 'spec_helper'

describe SimpleSlack::Botter do
  let(:client)    { SimpleSlack::Client.new(SIMPLE_SLACK_API_TOKEN) }
  let(:botter)    { client.bot }

  describe "#set_condition" do
    context '(when params all)' do
      it 'is params status all' do
        expect(botter.set_condition(channel: :all, user: :all, text: :all)).to eq ({ channel: "all", user: "all", text: "all" })
      end
    end
    context '(when channel set test)' do
      it 'is channel parms test' do
        expect(botter.set_condition(channel: "test")).to eq ( { channel: { :id=>"C0P74L08G", :name=>"test" }, user: "all", text: "all" })
      end
    end
    context '(when user set slackbot)' do
      it 'is user parasm slackbot' do
        expect(botter.set_condition(user: "slackbot")).to eq ({ channel: "all", user: { :id=>"USLACKBOT", :name=>"slackbot" }, text: "all" })
      end
    end
  end
end
