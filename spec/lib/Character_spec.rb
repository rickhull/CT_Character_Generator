require 'spec_helper'

describe Character do
  
  describe '#upp' do
    context 'when first created' do
      it 'is 6 hexidecimal characters' do
        expect(subject.upp).to match(/[0-9A-F]{6}/)
      end
    end
  end

  describe '#gender' do
    context 'when first created' do
      it 'is either Male or Female' do
        genders = ['Female', 'Male']
        expect(genders).to include(subject.gender)
      end
    end
  end
        
end
