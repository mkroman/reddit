# encoding: utf-8

require_relative './spec_helper'

describe Reddit do
  describe ".initialize" do
    it "should initialize a new client" do
      expect(Reddit::Client).to receive :new

      subject.initialize $config['client_id'], $config['client_secret']
    end
  end

  describe ".client" do
    let(:object) { double :object }

    it "should return the initialized client" do
      expect(Reddit::Client).to receive(:new).and_return object

      subject.initialize $config['client_id'], $config['client_secret']
      expect(subject.client).to eq object
    end
  end
end