require 'traveller/data'
require 'traveller/character'

module Traveller
  class Character
    def self.generate(basic = {})
      self.new(basic: Generator.basic.merge(basic), upp: Generator.upp)
    end
  end

  module Generator
    def self.name(gender)
      case gender.to_s.downcase
      when 'm', 'male'
        Traveller::Data.sample('male_names.txt')
      when 'f', 'female'
        Traveller::Data.sample('female_names.txt')
      else
        raise "unknown gender: #{gender}"
      end
    end

    def self.gender
      Traveller.roll(dice: 1) > 3 ? 'M' : 'F'
    end

    def self.hair(tone: nil, body: nil, color: nil, length: nil)
      tone ||= Traveller::Data.sample('hair_tone.txt')
      body ||= Traveller::Data.sample('hair_body.txt')
      color ||= Traveller::Data.sample('hair_colors.txt')
      length ||= Traveller::Data.sample('hair_length.txt')
      [tone, body, color, length].join(' ')
    end

    def self.appearance(hair: nil, skin: nil)
      hair ||= self.hair
      skin ||= Traveller::Data.sample('skin_tones.txt')
      "#{hair} hair with #{skin} skin"
    end

    def self.plot
      Traveller::Data.sample('plots.txt')
    end

    def self.temperament
      Traveller::Data.sample('temperaments.txt')
    end

    def self.basic
      gender = self.gender
      { name: self.name(gender),
        gender: gender,
        appearance: self.appearance,
        age: 18,
        plot: self.plot,
        temperament: self.temperament }
    end

    def self.upp
      [:strength, :dexterity, :endurance,
       :intelligence, :education, :social_status].reduce({}) { |hsh, sym|
        hsh.merge(sym => Traveller.roll(faces: 6, dice: 2, count: 1))
      }
    end
  end
end
