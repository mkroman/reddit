# encoding: utf-8

require_relative '../spec_helper'

describe Reddit::Client do
  describe "#initialize" do
    subject { Reddit::Client.new 'abc', 'def' }

    it "should have default options" do
      expect(subject.options).to be_kind_of Hash
    end

    it "should have a client id" do
      client_id = subject.instance_variable_get :@client_id

      expect(client_id).to eq 'abc'
    end

    it "should have a client secret" do
      client_secret = subject.instance_variable_get :@client_secret

      expect(client_secret).to eq 'def'
    end
  end

  describe "#authenticate", :vcr => { record: :new_episodes } do
    subject { Reddit::Client.new $config['client_id'], $config['client_secret'] }

    context "when the credentials are valid" do
      it "should authenticate" do
        subject.authenticate $config['username'], $config['password']

        expect(subject.access_token).to_not be_nil
      end

      it "should not raise an error" do
        expect do
          subject.authenticate $config['username'], $config['password']
        end.to_not raise_error
      end
    end
    
    context "when the credentials are not valid" do
      it "should raise an error" do
        expect do
          subject.authenticate 'invalid', 'password'
        end.to raise_error Reddit::Client::OAuthTokenError
      end
    end
  end
end