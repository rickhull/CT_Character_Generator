#require 'spec_helper'
require 'marine'

describe Marine do

  describe '#rank' do
    context 'when no set rank' do
      it 'returns Private' do
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

