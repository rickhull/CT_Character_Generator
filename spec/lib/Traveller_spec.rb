require 'Traveller'

module Traveller

  describe 'First name' do
    it 'should be more than one character long.' do
      @first_name = Traveller.first_name('female')
      expect(@first_name.length).to be >= 2
    end
  end

  describe 'Last name' do
    it 'should be more than one character long.' do
      @last_name = Traveller.last_name
      expect(@last_name.length).to be >= 2
    end
  end

  describe 'Full name' do
    before (:each) do
      @name = Traveller.name('female')
    end

    it 'should contain a space.' do
      expect(@name).to match(/ /)
    end

    it 'should be more than 5 characters long.' do
      expect(@name.length).to be > 5
    end

  end

  describe 'Set stat' do
    it 'should set a stat to a specific number' do
      @upp = '777777'
      @new_upp = Traveller.set_stat(@upp, 0, "A")
      expect(@new_upp).to eq('A77777')
    end
  end

  describe 'Modify stats' do
    before (:each) do
      @upp = '777777'
    end

    it 'should change a stat' do
      @old_stat = @upp[0,1].to_i(16)
      @new_upp = Traveller.modify_stat(@upp, 0, -2)
      @new_stat = @new_upp[0,1].to_i(16)
      @difference = @old_stat - @new_stat
      expect(@difference).to equal(2)
    end

    it 'should max a stat out' do
      @new_upp = Traveller.modify_stat(@upp, 0, 25)
      @new_stat = @new_upp[0,1].to_i(16)
      expect(@new_stat).to eq(15)
    end
     
    it 'should min a stat out' do
      @new_upp = Traveller.modify_stat(@upp, 0, -20)
      @new_stat = @new_upp[0,1].to_i(16)
      expect(@new_stat).to eq(0)
    end 
  end

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


  describe 'Should return true if nobility.' do
    it 'returns true if upp 11+' do
      @upp = '77777B'
      @is_noble = Traveller.noble?(@upp)
      expect(@is_noble).to eq(true)
    end

    it 'returns false if upp <= 10' do
      @upp = '77777A'
      @is_noble = Traveller.noble?(@upp)
      expect(@is_noble).to eq(false)
    end
  end

  describe 'Should return a title if nobility.' do

    it 'returns Knight if gender male and Soc B.' do
      @gender = 'male'
      @upp = '77777B'
      @title = Traveller.noble(@gender, @upp)
      expect(@title).to eq('Knight')
    end

    it 'returns Dame if gender female and Soc B.' do
      @gender = 'female'
      @upp = '77777B'
      @title = Traveller.noble(@gender, @upp)
      expect(@title).to eq('Dame')
    end

    it 'returns Baron if gender male and Soc C.' do
      @gender = 'male'
      @upp = '77777C'
      @title = Traveller.noble(@gender, @upp)
      expect(@title).to eq('Baron')
    end

    it 'returns Baroness if gender female and Soc C.' do
      @gender = 'female'
      @upp = '77777C'
      @title = Traveller.noble(@gender, @upp)
      expect(@title).to eq('Baroness')
    end
  
    it 'returns Marquis if gender male and Soc D.' do
      @gender = 'male'
      @upp = '77777D'
      @title = Traveller.noble(@gender, @upp)
      expect(@title).to eq('Marquis')
    end

    it 'returns Marquesa if gender female and Soc D.' do
      @gender = 'female'
      @upp = '77777D'
      @title = Traveller.noble(@gender, @upp)
      expect(@title).to eq('Marquesa')
    end
    
    it 'returns Count if gender male and Soc E.' do
      @gender = 'male'
      @upp = '77777E'
      @title = Traveller.noble(@gender, @upp)
      expect(@title).to eq('Count')
    end

    it 'returns Countess if gender female and Soc E.' do
      @gender = 'female'
      @upp = '77777E'
      @title = Traveller.noble(@gender, @upp)
      expect(@title).to eq('Countess')
    end

    it 'returns Duke if gender male and Soc F.' do
      @gender = 'male'
      @upp = '77777F'
      @title = Traveller.noble(@gender, @upp)
      expect(@title).to eq('Duke')
    end

    it 'returns Duchess if gender female and Soc F.' do
      @gender = 'female'
      @upp = '77777F'
      @title = Traveller.noble(@gender, @upp)
      expect(@title).to eq('Duchess')
    end

    it 'returns an empty string if gender male and Soc 2-A.' do
      @gender = 'male'
      @upp = '77777A'
      @title = Traveller.noble(@gender, @upp)
      expect(@title).to eq('')
    end

    it 'returns an empty string if gender female and Soc 2-A.' do
      @gender = 'female'
      @upp = '77777A'
      @title = Traveller.noble(@gender, @upp)
      expect(@title).to eq('')
    end
  end

  describe 'UPP should match proper format.' do
    before (:each) do
      @upp = Traveller.upp
    end

    it 'should be 6 uppercase hexidecimal numbers.' do
      expect(@upp).to match(/[0-9A-F]{6}/)      
    end
  end

  describe 'Gender should be Male or Female.' do
    genders = ['male', 'female']
    before (:each) do
      @gender = Traveller.gender
    end

    it 'is either Male or Female' do
      expect(genders).to include(@gender)
    end
  end
end 
