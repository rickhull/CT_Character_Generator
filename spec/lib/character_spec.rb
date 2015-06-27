#require 'spec_helper'
require 'character'

describe Character do
  it 'has a career' do
    expect(subject).to respond_to(:career) 
  end
  it 'has a gender' do
    expect(subject).to respond_to(:gender) 
  end

  describe '#skills' do
    context 'when no skills set' do
      it 'returns empty hash' do
        expect(subject.skills.count).to be == 0
      end
    end
    context 'when a skill first added' do
      let(:skill) {'Pilot'}
      let(:skill_level) {1}
      before { subject.skills[skill] = skill_level }

      it 'returns a skill level of 1' do
        expect(subject.skills[skill]).to be == skill_level
      end
    end
    context 'when a skill is incrementd' do
      let(:skill) {'Engineering'}
      it 'returns nil when skill not yet added' do
        expect(subject.skills[skill]).to be == nil
      end
    end

    context 'when a skill increased' do
      let(:skill) {'Navigation'}
      let(:initial_level) { 0 }
      let(:default_level) { 1 }
      let(:high_level) { 3 }
      before { subject.increase_skill(skill, initial_level) }
      it 'returns 0 with new skill' do
        subject.skills[skill] == initial_level
      end
      it 'returns +1 when using the default level value' do
        old_level = subject.skills[skill]
        subject.increase_skill(skill)
        expect(subject.skills[skill]).to be == old_level + default_level
      end
      it 'returns specifically increased value when non-default used.' do
        old_level = subject.skills[skill]
        subject.increase_skill(skill, high_level)
        expect(subject.skills[skill]).to be == old_level + high_level
      end
      it 'returns combination of default and higher skills.' do
        subject.increase_skill(skill)
        initial_level = subject.skills[skill]
        subject.increase_skill(skill, high_level)
        expect(subject.skills[skill]).to be == default_level + high_level
      end
    end 
  
  end

  describe '#age' do
    context 'when terms are not set' do
      it 'returns the default age' do
        expect(subject.age).to be >= Character::DEFAULT_AGE
        expect(subject.age).to be <= Character::DEFAULT_AGE + 3
      end
    end

    context 'when terms are set' do
      let(:terms) { 4 }

      before { subject.terms = terms }

      it 'calculates age based on terms' do
        expect(subject.age).to be >= 34
        expect(subject.age).to be <= 37
      end
    end
  end

  describe '#name' do
    context 'when set' do
      it 'returns the right name' do
        expect(subject.name.length).to be >= 4
      end
    end
  end

  describe '#terms' do
    context 'when not set' do
      it 'returns 0' do
        expect(subject.terms).to be 0
      end
    end
  end

  describe '#officer' do
    context 'when not set' do
      it 'returns false' do
        expect(subject.officer).to be_falsey
      end
    end
    context 'when given an easy roll' do
      before { subject.officer(1) }
      it 'returns true' do
        expect(subject.officer).to be_truthy
      end
    end
    context 'when given an impossible roll' do
      before { subject.officer(14) }
      it 'returns false' do
        expect(subject.officer).to be_falsey
      end
    end
  end

  describe '#upp' do
    context 'when first created' do
      it 'returns a 6 character string' do
        expect(subject.upp.length).to be == 6
      end
      it 'is all hexidecimal characters' do
        expect(subject.upp).to match(/[0-9A-F]{6}/)
      end
    end
  end

end
