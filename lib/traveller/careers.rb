module Traveller
  class Career
    class UnknownAssignment < RuntimeError; end
    class MusterError < RuntimeError; end

    def self.advanced_skills?(stats)
      stats.education >= 8
    end

    QUALIFY_CHECK = 5
    SURVIVAL_CHECK = 6
    ADVANCEMENT_CHECK = 9

    STATS = Array.new(6) { {} }
    SERVICE_SKILLS = Array.new(6) { :default }
    ADVANCED_SKILLS = Array.new(6) { :default }
    SPECIALIST_SKILLS = {
      default: Array.new(6) { :default }
    }

    EVENTS = {
      2 => nil,
      3 => nil,
      4 => nil,
      5 => nil,
      6 => nil,
      7 => nil,
      8 => nil,
      9 => nil,
      10 => nil,
      11 => nil,
      12 => nil,
    }

    MISHAPS = {
      1 => nil,
      2 => nil,
      3 => nil,
      4 => nil,
      5 => nil,
      6 => nil,
    }

    CASH = {
      2 => -200,
      3 => -100,
      4 => 200,
      5 => 400,
      6 => 600,
      7 => 800,
      8 => 1000,
      9 => 2000,
      10 => 4000,
      11 => 8000,
      12 => 12000,
    }

    attr_reader :stats, :skills, :benefits
    attr_accessor :term, :active, :rank

    def initialize(assignment = nil,
                   stats: Character::Stats.empty, skills: Hash.new(0),
                   term: 0, active: false, rank: 0, benefits: {})
      if assignment and !self.class::SPECIALIST_SKILLS.key?(assignment)
        raise(UnknownAssignment, assignment.inspect)
      end
      @assignment = assignment

      # track any stats and skills acquired in the career
      @stats = stats
      @skills = skills

      # career tracking
      @term = term
      @active = active
      @rank = rank
      @benefits = benefits  # acquired equipment, ships / shares
    end

    def basic_training(first_career: false)
      if first_career
        self.class::SERVICE_SKILLS.each { |sym|
          @skills[sym] = 0
        }
      else
        sym = Traveller.choose("Service skill", *self.class::SERVICE_SKILLS)
        @skills[sym] = 0
      end
    end

    def assignment
      @assignment ||= Traveller.choose(*self.class::SPECIALIST_SKILLS.keys)
    end

    def qualify_check?(career_count, _stats)
      dm = -1 * career_count
      (Traveller.roll('2d6') + dm) >= self.class::QUALIFY_CHECK
    end

    def survival_check?(dm = 0)
      (Traveller.roll('2d6') + dm) >= self.class::SURVIVAL_CHECK
    end

    def advancement_check?(dm = 0)
      (Traveller.roll('2d6') + dm) >= self.class::ADVANCEMENT_CHECK
    end

    def training_roll!(advanced: false)
      roll = Traveller.roll('1d6')
      @stats.boost self.class::STATS.fetch(roll - 1)
      @skills[self.class::SERVICE_SKILLS.fetch(roll - 1)] += 1
      @skills[self.class::ADVANCED_SKILLS.fetch(roll - 1)] += 1 if advanced
    end

    def specialist_skill_roll!
      roll = Traveller.roll('1d6')
      skill =
        self.class::SPECIALIST_SKILLS.fetch(self.assignment).fetch(roll - 1)
      @skills[skill] += 1
    end

    def event_roll(dm = 0)
      roll = Traveller.roll('2d6')
      clamped = (roll + dm).clamp(2, 12)
      self.class::EVENTS.fetch(clamped)
    end

    def mishap_roll
      roll = Traveller.roll('1d6')
      self.class::MISHAPS.fetch(roll)
    end

    def cash_roll(dm = 0)
      roll = Traveller.roll('2d6')
      clamped = (roll + dm).clamp(2, 12)
      self.class::CASH.fetch(clamped)
    end

    def retirement_benefit
      @term >= 5 ? @term * 2000 : 0
    end

    def dump
      [self.class, @assignment,
       {
         stats: @stats.to_h,
         skills: @skills,
         term: @term,
         active: @active,
         rank: @rank }]
    end

    def muster_out(dm = 0)
      if @active
        @active = false
        raise(MusterError, "career has not started") unless @term > 0
        cash_benefit = 0
        @term.clamp(0, 3).times {
          cash_benefit += self.cash_roll
        }
        cash_benefit + self.retirement_benefit
      end
    end

    def name
      self.class.name.split('::').last
    end
  end

  class Drifter < Career
  end

  class MilitaryCareer < Career
    COMMISSION_CHECK = 9
    OFFICER_SKILLS = Array.new(6) { :default }
    OFFICER_RANKS = {}

    attr_reader :officer, :officer_rank

    def initialize(assignment = nil, **kwargs)
      super(assignment, **kwargs)
      @officer = false
    end

    def commission_check?(dm = 0)
     (Traveller.roll('2d6') + dm) >= self.class::COMMISSION_CHECK
    end

    def commission!
      @officer = true
      @officer_rank = 1
    end

    def officer_skill_roll!(dm = 0)
      roll = Traveller.roll('1d6')
      skill = self.class::OFFICER_SKILLS.fetch(roll - 1)
      @skills[skill] += 1
    end
  end

  class Navy < MilitaryCareer
  end

  class Army < MilitaryCareer
  end

  class Marines < MilitaryCareer
  end

  class MerchantMarine < MilitaryCareer
  end

  class Agent < MilitaryCareer
  end

  class Scout < MilitaryCareer
    STATS = [:strength, :dexterity, :endurance,
             :intelligence, :education, nil].map { |sym|
      sym ? { sym => 1 } : {}
    }
    SERVICE_SKILLS = [:pilot_small_craft, :survival, :mechanic,
                      :astrogation, :comms, :gun_combat_group]
    ADVANCED_SKILLS = [:medic, :navigation, :engineer,
                       :computer, :space_science, :jack_of_all_trades]
    SPECIALIST_SKILLS = {
      courier: [:comms, :sensors, :pilot_spacecraft,
                :vacc_suit, :zero_g, :astrogation],
      survey: [:sensors, :persuade, :pilot_small_craft,
               :navigation, :diplomat, :streetwise],
      exploration: [:sensors, :pilot_spacecraft, :pilot_small_craft,
                    :life_science_any, :stealth, :recon],
    }

    # key: roll; values: title, skill, skill_value
    RANKS = {
      1 => [:scout, :vacc_suit, 1],
      3 => [:senior_scout, :pilot, 1],
    }

    def qualify_check?(career_count, stats)
      dm = stats.intelligence - career_count
      (Traveller.roll('2d6') + dm) >= 5
    end
  end
end
