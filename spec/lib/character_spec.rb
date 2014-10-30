require 'spec_helper'
require 'character'

describe Character do
  it { should respond_to(:career) }
  it { should respond_to(:gender) }

  describe '#age' do
    context 'when terms are not set' do
      it 'returns the default age' do
        # expect(subject.age).to eql Character::DEFAULT_AGE
        subject.age.should == Character::DEFAULT_AGE
      end
    end

    context 'when terms are set' do
      let(:terms) { 4 }

      before { subject.terms = terms }

      it 'calculates age based on terms' do
        # expect(subject.age).to eql 34
        subject.age.should == 34
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
    context 'when set_upp has not been called' do
      it 'returns an empty string' do
        # expect(subject.upp).to eql ''
        subject.upp.should == ''
      end
    end
  end
end
