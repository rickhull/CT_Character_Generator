require 'whatever_provides_dice_dot_roll'

module TravellerChar
  module Generator
    def self.name
      'Jim'
    end

    def self.gender
      'M'
    end

    def self.appearance
      'big black boots and long brown hair'
    end

    def self.age
      21
    end

    def self.plot
      'stuff happened, and then some things'
    end

    def self.temperament
      'sleepy'
    end

    def self.basic
      { name: self.name,
        gender: self.gender,
        appearance: self.appearance,
        age: self.age,
        plot: self.plot,
        temperament: self.temperament }
    end

    def self.upp
      [:strength, :dexterity, :endurance,
       :intelligence, :education, :social_status].reduce({}) { |hsh, sym|
        hsh.merge(sym => Dice.roll_dice(6,2,1))
      }
    end
  end

  class Character
    def self.generate(basic: {})
      self.new(basic: Generator.basic.merge(basic), upp: Generator.upp)
    end

    def initialize(basic: {}, upp: {}, skills: {}, careers: {}, stuff: {})
      @name = basic.fetch(:name)
      @gender = basic.fetch(:gender)
      @appearance = basic.fetch(:appearance)
      @age = basic.fetch(:age)
      @plot = basic.fetch(:plot)
      @temperament = basic.fetch(:temperament)

      @strength = upp.fetch(:strength)
      @dexterity = upp.fetch(:dexterity)
      @endurance = upp.fetch(:endurance)
      @intelligence = upp.fetch(:intelligence)
      @education = upp.fetch(:education)
      @social_status = upp.fetch(:social_status)

      @skills = skills
      @careers = careers
      @stuff = stuff
    end
  end
end
