#require 'spec_helper'
require 'scout'

describe Scout do

  describe '#career' do
    context 'when career queried' do
      it 'returns Scout' do
        expect(subject.career).to match('Scout')
      end
    end
  end

  describe '#skills' do
    context 'when created' do
      it 'has base skills' do
        expect(subject.skills.keys).to include('Pilot')
      end
    end
  end


end
