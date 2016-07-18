require 'spec_helper'

describe SimpleSlack do
  let(:client) { SimpleSlack::Client.new(SIMPLE_SLACK_API_TOKEN) }

  describe 'VERSION' do
    it 'has a version number' do
      expect(SimpleSlack::VERSION).not_to be nil
    end
  end

  describe '#client' do 
    it 'success object make' do
      expect(client).to be_truthy
    end
  end

  describe '#get' do
    it 'is SimpleSlack::Getter class' do
      expect(client.get.class).to eq SimpleSlack::Getter
    end
  end

  describe '#post' do
    it 'is SimpleSlack::Poster class' do
      expect(client.post.class).to eq SimpleSlack::Poster
    end
  end

  describe '#bot' do
    it 'is SimpleSlack::Botter class' do
      expect(client.bot.class).to eq SimpleSlack::Botter
    end
  end

  describe '#toggl' do
    it 'is SimpleSlack::Toggl class' do
      expect(client.toggl.class).to eq SimpleSlack::Toggl
    end
  end
end
