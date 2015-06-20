# upp_spec.rb

#require 'spec_helper'
require 'upp'

module Ct_chargen

  describe 'UPP output should' do
    before(:each) do
      @char = Upp.new
      @char_upp = @char.rollupp
      @char_upp.to_s.strip
    end

    it "be 6 characters long" do
      #@char_upp.should have(6).characters
      @char_upp.size.to eq(6)
    end

    it "be hexidecimal digits" do
      @char_upp.should =~ /[0-9A-F]/
    end
      
  end

end

