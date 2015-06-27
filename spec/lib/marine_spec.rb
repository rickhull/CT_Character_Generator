#require 'spec_helper'
require 'marine'

describe Marine do

  describe '#rank' do
    context 'when no set rank' do
      it 'returns Private' do
        expect(subject.rank).to match('Private')
      end
    end 
  end

  describe '#career' do
    context 'when career queried' do
      it 'returns Marine' do
        expect(subject.career).to match('Marine')
      end
    end
  end

  describe '#skills' do
    context 'when created' do
      it 'has base skills' do
        expect(subject.skills.keys).to include('Blade')
        expect(subject.skills.keys).to include('GunCbt')
      end
    end
  end

end
