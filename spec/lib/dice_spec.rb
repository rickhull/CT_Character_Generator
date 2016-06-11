# dice_spec.rb

require 'dice'

module Ct_chargen

  describe 'Dice.roll2 should' do
    before() do
      dice = Dice.new
      @roll = dice.roll2
    end
    it 'should be between 2 and 12, inclusive.' do
      expect(@roll).to be_between(2,12)
    end
  end

  describe 'Dice.roll1 should' do
    before() do
      dice = Dice.new
      @roll = dice.roll1
    end

    it 'should be between 1 and 6, inclusive.' do
      expect(@roll).to be_between(1,6)
    end
  end

  describe 'Dice.average1 should' do
    before() do
      dice = Dice.new
      @roll = dice.average1
    end

    it 'should be between 1 and 6, inclusive.' do
      expect(@roll).to be_between(1,6)
    end
  end

  describe 'Dice.average2 should' do
    before() do
      dice = Dice.new
      @roll = dice.average2
    end

    it 'should be between 2 and 12, inclusive.' do
      expect(@roll).to be_between(2,12)
    end
  end
end
   
