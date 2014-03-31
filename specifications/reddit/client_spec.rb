# encoding: utf-8

require_relative '../spec_helper'

describe Reddit::Client do
  describe "#initialize" do
    it "should have default attributes" do
      expect(subject.options).to be_kind_of Hash
    end
  end
end