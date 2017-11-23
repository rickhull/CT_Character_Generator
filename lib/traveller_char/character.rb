module TravellerChar
  class Character
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
