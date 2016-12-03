require 'spec_helper'

describe SimpleSlack::Toggl do
  let(:client) { SimpleSlack::Client.new(SIMPLE_SLACK_API_TOKEN) }
  let(:toggl)  { client.toggl }

  describe '#send_morning_message' do
    it 'morning message validate' do
      expect(toggl.send_morning_message).to be_truthy
    end
  end
  describe '#send_noon_message' do
    it 'noon message validate' do
      expect(toggl.send_noon_message).to be_truthy
    end
  end
  describe '#send_after_noon_message' do
    it 'after noon message validate' do
      expect(toggl.send_after_noon_message).to be_truthy
    end
  end
  describe '#send_night_message' do
    it 'night message validate' do
      expect(toggl.send_night_message).to be_truthy
    end
  end
  describe '#send_regular_message' do
    it 'regular message validate' do
      expect(toggl.send_regular_message).to be_truthy
    end
  end
  describe '#send_dailyreport_message' do
    it 'dailyreport message validate' do
      expect(toggl.send_dailyreport_message).to be_truthy
    end
  end

  describe '#post_message' do
    before do
      toggl.configure do |config|
        config.post_channels  = ["test"]
        config.post_ims       = ["slackbot"]
        config.post_bot_name  = "tester"
        config.post_bot_image = ":ghost:"
      end
    end
    context '(when no type param)' do
      it "return regular message" do
        expect(toggl.post_message).to include "■現在作業中の内容"
      end
    end
    context '(when type is morning)' do
      it "return morning message" do
        expect(toggl.post_message(:morning)).to include "おはようございます"
      end
    end
    context '(when type is noon)' do
      it "return noon message" do
        expect(toggl.post_message(:noon)).to include "お昼です"
      end
    end
    context '(when type is after_noon)' do
      it "return after noon message" do
        expect(toggl.post_message(:after_noon)).to include "お昼休み終了です。"
      end
    end
    context '(when type is night)' do
      it "return night message" do
        expect(toggl.post_message(:night)).to include "業務終了の時間です。"
      end
    end
    context '(when type is dailyreport)' do
      it "return dailyreport message" do
        expect(toggl.post_message(:dailyreport)).to include "日報"
      end
    end
    context '(when type is regular)' do
      it "return regular message" do
        expect(toggl.post_message(:regular)).to include "■現在作業中の内容"
      end
    end
  end

  describe '#entries_by_tags' do
    it 'return entries' do
      entries = toggl.entries_by_tags("#2661")
      puts entries
    end
  end
end
