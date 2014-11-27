require 'spec_helper'
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
        subject.age.should == Character::DEFAULT_AGE
      end
    end

    context 'when terms are set' do
      let(:terms) { 4 }

      before { subject.terms = terms }

      it 'calculates age based on terms' do
        subject.age.should be >= 36
        subject.age.should be <= 38
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
      #let(:name) {'Allesandro'}
      before { subject.name = 'Allesandro' }
      it 'returns the right name' do
        subject.name.should === 'Allesandro'
      end
    end
  end

  describe '#terms' do
    context 'when not set' do
      it 'returns 0' do
        # expect(subject.terms).to eql 0
        subject.terms.should == 0
      end
    end
  end

  describe '#upp' do
    context 'when set_stat has not been called' do
      it 'returns an empty string' do
        # expect(subject.upp).to eql ''
        subject.upp.should == ''
      end
    end

    context 'when set_stat has been called on all stats' do
      before (:all) do
        subject.set_stat('Str', '5')
        subject.set_stat('Dex', '6')
        subject.set_stat('End', '7')
        subject.set_stat('Int', '8')
        subject.set_stat('Edu', '9')
        subject.set_stat('Soc', 'A')
      end

      it 'returns a particular 6 character string' do
        subject.upp.should == '56789A'
      end 

      it 'returns a 6 character string' do
        subject.upp.length.should == 6
      end

      it 'returns the right value for a chosen stat' do
        subject.get_stat('Str').should == '5'
      end

      it 'returns the right value for a low stat modifier' do
        subject.get_stat_modifier(0, 6, -1, 9, 2).should == -1
      end

      it 'returns the right value for a high stat modifier' do
        subject.get_stat_modifier(5, 6, -1, 9, 2).should == 2
      end

      it 'returns the right value for an average stat modifier' do
        subject.get_stat_modifier(2, 6, -1, 9, 2).should == 0
      end

    end
  end


end
