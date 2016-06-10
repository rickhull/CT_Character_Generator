#require 'spec_helper'
require 'entertainer'

describe Entertainer do

  describe '#career' do
    context 'when career queried' do
      it 'returns Entertainer' do
        expect(subject.career).to match('Entertainer')
      end
    end
  end

  describe '#skills' do
    context 'when created' do
      it 'has base skills' do
        expect(subject.skills.keys).to include('Art(any)')
      end
    end
  end

end
