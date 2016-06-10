#require 'spec_helper'
require 'warder'

describe Warder do

  describe '#career' do
    context 'when career queried' do
      it 'returns Warder' do
        expect(subject.career).to match('Warder')
      end
    end
  end

  describe '#skills' do
    context 'when created' do
      it 'has base skills' do
        expect(subject.skills.keys).to include('Streetwise')
      end
    end
  end

end
