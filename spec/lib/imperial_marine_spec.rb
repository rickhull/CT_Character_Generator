require 'spec_helper'
require 'imperial_marine'

describe Imperial_Marine do

  describe '#rank' do
    context 'when set rank' do
      before { subject.rank = 'Private' }
      it 'returns rank' do
        subject.rank.should == 'Private'
      end
    end 
  end

  describe '#career' do
    context 'when career queried' do
      it 'returns Marine' do
        subject.career.should == 'Marine'
      end
    end
  end

end

