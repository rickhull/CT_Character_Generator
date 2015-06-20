#require 'spec_helper'
require 'character'

describe Character do
  it { should respond_to(:career) }
  it { should respond_to(:gender) }

  describe '#skills' do
    context 'when no skills set' do
      it 'returns empty hash' do
        subject.skills.count == 0
      end
    end
    context 'when a skill first added' do
      let(:skill) {'Pilot'}
      let(:skill_level) {1}
      before { subject.skills[skill] = skill_level }

      it 'returns a skill level of 1' do
        subject.skills[skill] == skill_level
      end
    end
    context 'when a skill is incrementd' do
      let(:skill) {'Engineering'}
      it 'returns nil when skill not yet added' do
        subject.skills[skill] == nil
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
        subject.skills[skill].should == old_level + default_level
      end
      it 'returns specifically increased value when non-default used.' do
        old_level = subject.skills[skill]
        subject.increase_skill(skill, high_level)
        subject.skills[skill].should == old_level + high_level
      end
      it 'returns combination of default and higher skills.' do
        subject.increase_skill(skill)
        initial_level = subject.skills[skill]
        subject.increase_skill(skill, high_level)
        subject.skills[skill].should == default_level + high_level
      end
    end 
  
  end

  describe '#age' do
    context 'when terms are not set' do
      it 'returns the default age' do
        subject.age.should be >= Character::DEFAULT_AGE
        subject.age.should be <= Character::DEFAULT_AGE + 3
      end
    end

    context 'when terms are set' do
      let(:terms) { 4 }

      before { subject.terms = terms }

      it 'calculates age based on terms' do
        subject.age.should be >= 34
        subject.age.should be <= 37
      end
    end
  end

  describe '#name' do
    context 'when not set' do
      it 'returns a blank string when name not set' do
        subject.name.should == '' 
      end
    end
    context 'when set' do
      before { subject.set_name }
      it 'returns the right name' do
        subject.name.length.should >= 3
      end
    end
  end

  describe '#terms' do
    context 'when not set' do
      it 'returns 0' do
        subject.terms.should == 0
      end
    end
  end

  describe '#officer' do
    context 'when not set' do
      it 'returns false' do
        subject.officer.should == false
      end
    end
    context 'when given an easy roll' do
      before { subject.officer(1) }
      it 'returns true' do
        subject.officer.should == true
      end
    end
    context 'when given an impossible roll' do
      before { subject.officer(14) }
      it 'returns false' do
        subject.officer.should == false
      end
    end
  end

  describe '#upp' do
    context 'when first created' do
      it 'returns a 6 character string' do
        subject.upp.length.should == 6
      end
      it 'is all hexidecimal characters' do
        subject.upp.should match /[0-9A-F]{6}/
      end
    end
  end


end
