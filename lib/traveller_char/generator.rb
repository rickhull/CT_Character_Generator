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
      rolln = -> (faces, dice) { Array.new(dice) { rand(faces) + 1 } }
      (Array.new(count) { rolln.(faces, dice).sum }.sum.to_f / count).round
    end

    def self.name
      TravellerChar::Data.sample('names.txt')
    end

    def self.gender
      self.roll(dice: 1) > 3 ? 'M' : 'F'
    end

    def self.hair(tone: nil, body: nil, color: nil, length: nil)
      tone ||= TravellerChar::Data.sample('hair_tone.txt')
      body ||= TravellerChar::Data.sample('hair_body.txt')
      color ||= TravellerChar::Data.sample('hair_colors.txt')
      length ||= TravellerChar::Data.sample('hair_length.txt')
      [tone, body, color, length].join(' ')
    end

    def self.appearance(hair: nil, skin: nil)
      hair ||= self.hair
      skin ||= TravellerChar::Data.sample('skin_tones.txt')
      "#{hair} hair with #{skin} skin"
    end

    def self.plot
      TravellerChar::Data.sample('plots.txt')
    end

    def self.temperament
      TravellerChar::Data.sample('temperaments.txt')
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
