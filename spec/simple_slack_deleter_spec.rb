require 'spec_helper'

describe SimpleSlack::Deleter do
  before do
    @client  = SimpleSlack::Client.new(SIMPLE_SLACK_API_TOKEN)
    @deleter = @client.delete
  end
  let(:client)  { @client }
  let(:deleter) { @deleter }

  describe "#chat" do
    context '(when sunncess)' do
      it 'is true' do
        expect(deleter.chat(ts: "000000", channel: "test")).to be_truthy
      end
    end
  end
end

