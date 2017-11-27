require 'traveller/character'
require 'traveller/data'

module Traveller::Character::Generator
  C = Traveller::Character
  D = Traveller::Data

  def self.character(descr = {})
    C.new(desc: self.desc.merge(descr),
          stats: C::Stats.roll)
  end

  def self.name(gender)
    case gender.to_s.downcase
    when 'm', 'male'
      D.sample('male_names.txt')
    when 'f', 'female'
      D.sample('female_names.txt')
    else
      raise "unknown gender: #{gender}"
    end
  end

  def self.gender
    Traveller.roll(dice: 1) > 3 ? 'M' : 'F'
  end

  def self.hair(tone: nil, body: nil, color: nil, length: nil)
    tone ||= D.sample('hair_tone.txt')
    body ||= D.sample('hair_body.txt')
    color ||= D.sample('hair_colors.txt')
    length ||= D.sample('hair_length.txt')
    [tone, body, color, length].join(' ')
  end

  def self.appearance(hair: nil, skin: nil)
    hair ||= self.hair
    skin ||= D.sample('skin_tones.txt')
    "#{hair} hair with #{skin} skin"
  end

  def self.plot
    D.sample('plots.txt')
  end

  def self.temperament
    D.sample('temperaments.txt')
  end

  def self.desc
    gender = self.gender
    C::Description.new(self.name(gender), gender, 18,
                       self.appearance, self.plot, self.temperament)
  end
end
