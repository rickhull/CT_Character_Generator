require 'Traveller'

module Traveller

  describe 'Roll 2 dice' do

    it 'should be between 2 and 12, inclusive.' do
      100.times do
        @roll = Traveller.roll_dice(6,2,1) 
        expect(@roll).to be_between(2,12)
      end
    end

    it 'should be an integer.' do
      100.times do
        @roll = Traveller.roll_dice(6,2,1) 
        expect(@roll).to be_kind_of(Integer)
      end
    end
  end

  describe 'Roll average of 4 dice' do

    it 'should be between 2 and 12, inclusive.' do
      100.times do
        @roll = Traveller.roll_dice(6,1,4) 
        expect(@roll).to be_between(1,6)
      end
    end

    it 'should be an integer.' do
      100.times do
        @roll = Traveller.roll_dice(6,1,4) 
        expect(@roll).to be_kind_of(Integer)
      end
    end
  end

end
