require 'spec_helper'

describe 'CharacterCreate' do
  
  describe '#upp' do
    context 'when first created' do
      it 'is 6 hexidecimal characters' do
        expect(subject.upp).to match(/[0-9A-F]{6}/)
      end
    end

    context 'after creation' do
      it 'can be changed.' do
        subject.name = "Fred Flintstone"
        expect(subject.name).to match("Fred Flintstone")
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

    context 'after creation' do
      it 'can be set' do
        subject.gender = "Hobbit"
        expect(subject.gender).to match("Hobbit")
      end
    end

  end
        
end
