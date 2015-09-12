require 'Traveller'

module Traveller

  describe 'Roll 2 dice' do

    it 'should be between 2 and 12, inclusive.' do
      100.times do
        @roll = Traveller.roll_dice(6,2,1) 
        expect(@roll).to be_between(2,12)
      end
    end

    it 'should be an integer.' do
      100.times do
        @roll = Traveller.roll_dice(6,2,1) 
        expect(@roll).to be_kind_of(Integer)
      end
    end
  end

  describe 'Roll average of 4 dice' do

    it 'should be between 2 and 12, inclusive.' do
      100.times do
        @roll = Traveller.roll_dice(6,1,4) 
        expect(@roll).to be_between(1,6)
      end
    end

    it 'should be an integer.' do
      100.times do
        @roll = Traveller.roll_dice(6,1,4) 
        expect(@roll).to be_kind_of(Integer)
      end
    end
  end


  describe 'Should return a title if nobility.' do
    
    it 'returns Knight if gender male and Soc B.' do
      @gender = 'male'
      @upp = '77777B'
      @title = Traveller.noble?(@gender, @upp)
      expect(@title).to eq('Knight')
    end

    it 'returns Dame if gender female and Soc B.' do
      @gender = 'female'
      @upp = '77777B'
      @title = Traveller.noble?(@gender, @upp)
      expect(@title).to eq('Dame')
    end

    it 'returns Baron if gender male and Soc C.' do
      @gender = 'male'
      @upp = '77777C'
      @title = Traveller.noble?(@gender, @upp)
      expect(@title).to eq('Baron')
    end

    it 'returns Baroness if gender female and Soc C.' do
      @gender = 'female'
      @upp = '77777C'
      @title = Traveller.noble?(@gender, @upp)
      expect(@title).to eq('Baroness')
    end
  
    it 'returns Marquis if gender male and Soc D.' do
      @gender = 'male'
      @upp = '77777D'
      @title = Traveller.noble?(@gender, @upp)
      expect(@title).to eq('Marquis')
    end

    it 'returns Marquesa if gender female and Soc D.' do
      @gender = 'female'
      @upp = '77777D'
      @title = Traveller.noble?(@gender, @upp)
      expect(@title).to eq('Marquesa')
    end
    
    it 'returns Count if gender male and Soc E.' do
      @gender = 'male'
      @upp = '77777E'
      @title = Traveller.noble?(@gender, @upp)
      expect(@title).to eq('Count')
    end

    it 'returns Countess if gender female and Soc E.' do
      @gender = 'female'
      @upp = '77777E'
      @title = Traveller.noble?(@gender, @upp)
      expect(@title).to eq('Countess')
    end

    it 'returns Duke if gender male and Soc F.' do
      @gender = 'male'
      @upp = '77777F'
      @title = Traveller.noble?(@gender, @upp)
      expect(@title).to eq('Duke')
    end

    it 'returns Duchess if gender female and Soc F.' do
      @gender = 'female'
      @upp = '77777F'
      @title = Traveller.noble?(@gender, @upp)
      expect(@title).to eq('Duchess')
    end

    it 'returns an empty string if gender male and Soc 2-A.' do
      @gender = 'male'
      @upp = '77777A'
      @title = Traveller.noble?(@gender, @upp)
      expect(@title).to eq('')
    end

    it 'returns an empty string if gender female and Soc 2-A.' do
      @gender = 'female'
      @upp = '77777A'
      @title = Traveller.noble?(@gender, @upp)
      expect(@title).to eq('')
    end
  end

  describe 'UPP should match proper format.' do
    before (:each) do
      @upp = Traveller.roll_upp
    end

    it 'should be 6 characters long.' do
      expect(@upp.size).to eq(6)
    end

    it 'should only be numeric and uppercase hexidecimal.' do
      expect(@upp).to match(/[0-9A-F]/)      
    end
  end




end 
