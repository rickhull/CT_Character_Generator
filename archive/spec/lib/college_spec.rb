#require 'spec_helper'
require 'college'

describe College do

  describe '#career' do
    context 'when career queried' do
      it 'returns College' do
        expect(subject.career).to match('College')
      end
    end
  end

  describe '#skills' do
    context 'when created' do
      it 'has base skills' do
        expect(subject.skills.keys).to include('Computer')
      end
    end
  end


end
