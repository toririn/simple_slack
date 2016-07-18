require 'spec_helper'

describe SimpleSlack::Poster do
  let(:client)    { SimpleSlack::Client.new(SIMPLE_SLACK_API_TOKEN) }
  let(:poster)    { client.post }
  let(:base_text) { "RspecTest@#{Time.now.strftime("%Y年%m月%d日%H時%M分")}に実行" }

  describe "#channels" do
    let(:send_text) { "#channels\n#{base_text}" }
    context '(when name)' do
      it 'is true and post successful' do
        expect(poster.channels(to: ["test", "test2"], text: send_text)).to eq true
      end
    end
  end

  describe "#channel" do
    let(:send_text) { "#channel\n#{base_text}" }
    context '(when id)' do
      it 'is true and post successful' do
        expect(poster.channel(to: "C0P74L08G", text: send_text)).to eq true
      end
    end
    context '(when name)' do
      it 'is true and post successful' do
        expect(poster.channel(to: "test", text: send_text)).to eq true
      end
    end
    context '(when no existent user)' do
      it 'is raise error' do
        expect{ poster.channel(to: "aaaaaaaaaa", text: send_text) }.to raise_error(RuntimeError, "チャンネルが見つかりませんでした。")
      end
    end
  end

  describe "#chat" do
    let(:send_text) { "#chat\n#{base_text}" }
    context '(when id)' do
      it 'is true and post successful' do
        expect(poster.chat(channel: "C0P74L08G", text: send_text, icon_emoji: ":joy:")).to eq true
        expect(poster.chat(user: "USLACKBOT", text: send_text)).to eq "yet"
      end
    end
    context '(when name)' do
      it 'is true and post successful' do
        expect(poster.chat(channel: "test", text: send_text)).to eq true
        expect(poster.chat(user: "slackbot", text: send_text)).to eq "yet"
      end
    end
  end

  describe "#ims" do
    let(:send_text) { "#ims\n#{base_text}" }
    context '(when id)' do
      it 'is true and post successful' do
        expect(poster.ims(to: ["USLACKBOT"], text: send_text)).to eq true
      end
    end
    context '(when name)' do
      it 'is true and post successful' do
        expect(poster.ims(to: ["slackbot"], text: send_text)).to eq true
      end
    end
  end

  describe "#im" do
    let(:send_text) { "#im\n#{base_text}" }
    context '(when id)' do
      it 'is true and post successful' do
        expect(poster.im(to: "USLACKBOT", text: send_text)).to eq true
      end
    end
    context '(when name)' do
      it 'is true and post successful' do
        expect(poster.im(to: "slackbot", text: send_text)).to eq true
      end
    end
    context '(when no existent user)' do
      it 'is raise error' do
        expect{ poster.im(to: "aaaaaaaaaa", text: send_text) }.to raise_error(RuntimeError, "IMが見つかりませんでした。")
      end
    end
  end

  describe "#user" do
   it 'return yet' do
      expect(poster.user(to: "test", text: "test")).to be_truthy
    end
  end
end
