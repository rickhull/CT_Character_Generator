require 'traveller'

class Traveller::Character
  Stats = Struct.new(:strength, :dexterity, :endurance,
                     :intelligence, :education, :social_status) do
    def self.roll(spec = '2d6')
      self.new(*Array.new(6) { Traveller.roll spec })
    end

    def self.empty
      self.new(*Array.new(6) { 0 })
    end

    def boost(hsh)
      hsh.each { |k,v| self[k] += v if self[k] }
      self
    end
  end

  Description = Struct.new(:name, :gender, :age,
                           :appearance, :plot, :temperament) do
    def self.new_with_hash(hsh)
      self.new(hsh[:name], hsh[:gender], hsh[:age],
               hsh[:appearance], hsh[:plot], hsh[:temperament])
    end

    def merge(other)
      other = self.class.new_with_hash(other) if other.is_a?(Hash)
      self.class.new(other.name || self.name,
                     other.gender || self.gender,
                     other.age    || self.age,
                     other.appearance || self.appearance,
                     other.plot       || self.plot,
                     other.temperament || self.temperament)
    end
  end

  def initialize(desc:, stats:, skills: Hash.new(0), careers: {}, stuff: {})
    @desc = desc
    @stats = stats
    @skills = skills
    @careers = careers
    @stuff = stuff
  end
end
