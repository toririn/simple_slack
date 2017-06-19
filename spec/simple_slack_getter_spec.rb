require 'spec_helper'

describe SimpleSlack::Getter do
  before :all do
    @client = SimpleSlack::Client.new(SIMPLE_SLACK_API_TOKEN)
    @getter = @client.get
  end
  let(:client) { SimpleSlack::Client.new(SIMPLE_SLACK_API_TOKEN) }
  let(:getter) { @getter }

  describe "#users" do
   it 'return all users id, name' do
      users = getter.users
      expect(users).to be_truthy
      puts users
    end

   it 'retual all users id, name, real_name, is_bot' do
     users = getter.users([:real_name, :is_admin])
     expect(users).to be_truthy
     puts users
   end
  end

  describe "#user" do
    context '(when id)' do
      it 'return USLACKBOT user' do
        user = getter.user('USLACKBOT')
        expect(user).to be_truthy
        puts user
      end
      it 'retual USLACKBOT user id, name, real_name, is_bot' do
        user = getter.user('USLACKBOT', [:real_name, :is_admin])
        expect(user).to be_truthy
        puts user
      end
    end
    context '(when name)' do
      it 'return USLACKBOT user' do
        user = getter.user('slackbot')
        expect(user).to be_truthy
        puts user
      end
      it 'retual USLACKBOT user id, name, real_name, is_bot' do
        user = getter.user('slackbot', [:real_name, :is_admin])
        expect(user).to be_truthy
        puts user
      end
    end
  end

  describe "#channels" do
   it 'return all channels id, name' do
      channels = getter.channels
      expect(channels).to be_truthy
      puts channels
    end

   it 'retual all channels id, name, creator, members' do
     channels = getter.channels([:creator, :members])
     expect(channels).to be_truthy
     puts channels
   end
  end

  describe "#channel" do
    context '(when id)' do
      it 'return general channel' do
        channel = getter.channel('C0P7588AD')
        expect(channel).to be_truthy
        puts channel
      end
      it 'retual general channel id, name, creator, members' do
        channel = getter.channel('C0P7588AD', [:creator, :members])
        expect(channel).to be_truthy
        puts channel
      end
    end
    context '(when name)' do
      it 'return general channel' do
        channel = getter.channel('general')
        expect(channel).to be_truthy
        puts channel
      end
      it 'retual general channel id, name, creator, members' do
        channel = getter.channel('general', [:creator, :members])
        expect(channel).to be_truthy
        puts channel
      end
    end
  end

  describe "#images" do
   it 'return all user_id and image_url' do
      images = getter.images
      expect(images).to be_truthy
      puts images
    end

   it 'retual all user_id, image_url and image_72' do
     images = getter.images([:image_72])
     expect(images).to be_truthy
     puts images
   end
  end

  describe "#image" do
    context '(when id)' do
      it 'return slackbot id, name, image_url' do
        image = getter.image('USLACKBOT')
        expect(image).to be_truthy
        puts image
      end
      it 'retual slackbot id, name, image_url. image_72_url' do
        image = getter.image('USLACKBOT', [:image_72])
        expect(image).to be_truthy
        puts image
      end
    end
    context '(when name)' do
      it 'return slackbot id, name, image_url' do
        image = getter.image('slackbot')
        expect(image).to be_truthy
        puts image
      end
      it 'retual slackbot id, name, image_url, image_72_url' do
        image = getter.image('slackbot', [:image_72])
        expect(image).to be_truthy
        puts image
      end
    end
  end

  describe "#ims" do
   it 'return all user info and im_id' do
      ims = getter.ims
      expect(ims).to be_truthy
      puts ims
    end
   it 'retual user_info and im_id, is_im' do
     ims = getter.ims([:is_im])
     expect(ims).to be_truthy
     puts ims
   end
  end

  describe "#im" do
    context '(when id)' do
      it 'return slackbot id, name, im_id' do
        im = getter.im('USLACKBOT')
        expect(im).to be_truthy
        puts im
      end
      it 'retual slackbot id, name, im_id. is_im' do
        im = getter.im('USLACKBOT', [:is_im])
        expect(im).to be_truthy
        puts im
      end
    end
    context '(when name)' do
      it 'return slackbot id, name, im_id' do
        im = getter.im('slackbot')
        expect(im).to be_truthy
        puts im
      end
      it 'retual slackbot id, name, im_id, is_im' do
        im = getter.im('slackbot', [:is_im])
        expect(im).to be_truthy
        puts im
      end
    end
  end

  describe "#chats" do
   it 'return yet' do
      expect(getter.chats).to be_truthy
    end
  end

  describe "#chat" do
   it 'return yet' do
      expect(getter.chat).to be_truthy
    end
  end
end
