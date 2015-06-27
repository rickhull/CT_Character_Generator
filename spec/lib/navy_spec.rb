#require 'spec_helper'
require 'navy'

describe Navy do

  describe '#rank' do
    context 'when no set rank' do
      it 'returns Spacehand Recruit' do
        expect(subject.rank).to match('Spacehand Recruit')
      end
    end 
  end

  describe '#career' do
    context 'when career queried' do
      it 'returns Navy' do
        expect(subject.career).to match('Navy')
      end
    end
  end

end
