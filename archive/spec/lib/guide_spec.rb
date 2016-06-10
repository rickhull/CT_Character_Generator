#require 'spec_helper'
require 'guide'

describe Guide do

  describe '#career' do
    context 'when career queried' do
      it 'returns Guide' do
        expect(subject.career).to match('Guide')
      end
    end
  end

  describe '#skills' do
    context 'when created' do
      it 'has base skills' do
        expect(subject.skills.keys).to include('CbtR')
      end
    end
  end


end
