require 'traveller_char/data'
require 'traveller_char/character'

module TravellerChar
  class Character
    def self.generate(basic = {})
      self.new(basic: Generator.basic.merge(basic), upp: Generator.upp)
    end
  end

  module Generator
    def self.roll(faces: 6, dice: 2, count: 1)
      roll1 = -> (faces) { rand(faces) + 1 }
      rolln = -> (dice, faces) { Array.new(dice) { roll1.(faces) } }
      roll_sum = Array.new(count).reduce(0) { |sum, _|
        sum + rolln.(dice, faces).sum
      }
      (roll_sum.to_f / count).round
    end

    def self.name
      'Jim'
    end

    def self.gender
      self.roll(dice: 1) > 3 ? 'M' : 'F'
    end

    def self.appearance
      'big black boots and long brown hair'
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
        age: 18,
        plot: self.plot,
        temperament: self.temperament }
    end

    def self.upp
      [:strength, :dexterity, :endurance,
       :intelligence, :education, :social_status].reduce({}) { |hsh, sym|
        hsh.merge(sym => self.roll(faces: 6, dice: 2, count: 1))
      }
    end
  end
end
