require 'traveller'

module Traveller
  class Homeworld
    TRAITS = {
      agricultural: :animals,
      asteroid: :zero_g,
      desert: :survival,
      fluid_oceans: :seafarer,
      garden: :animals,
      high_technology: :computers,
      high_population: :streetwise,
      ice_capped: :vacc_suit,
      industrial: :trade,
      low_technology: :survival,
      poor: :animals,
      rich: :carouse,
      water_world: :seafarer,
      vacuum: :vacc_suit,
      education: [:admin, :advocate, :art, :carouse, :comms,
                  :computer, :drive, :engineer, :language, :medic,
                  :physical_science, :life_science, :social_science,
                  :space_science, :trade],
    }
    CHAR_MIN = 3
    CHAR_MAX = 5

    attr_reader :name, :traits

    def initialize(name, traits = [])
      @name = name
      if traits.size > self.class::CHAR_MAX
        warn "lots of world traits: #{traits}"
      elsif traits.empty?
        sample_num = rand(CHAR_MAX - CHAR_MIN + 1) + CHAR_MIN
        traits = self.class::TRAITS.keys.sample(sample_num)
      end
      @traits = traits
      @traits.each { |sym|
        raise "bad trait: #{sym}" unless self.class::TRAITS.key?(sym)
      }
    end

    # available skills -- only a fraction of which should apply to a
    # character's background skills
    def skills
      hsh = {}
      @traits.each { |sym|
        skill = self.class::TRAITS.fetch(sym)
        if skill.is_a?(Array)
          skill.each { |sk| hsh[sk] = 0 }
        else
          hsh[skill] = 0
        end
      }
      hsh
    end
  end
end
