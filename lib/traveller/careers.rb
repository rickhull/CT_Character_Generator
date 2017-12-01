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

    RANKS = {}

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
                   term: 0, active: false, rank: 0, benefits: {})
      if assignment and !self.class::SPECIALIST_SKILLS.key?(assignment)
        raise(UnknownAssignment, assignment.inspect)
      end
      @assignment = assignment

      # career tracking
      @term = term
      @active = active
      @rank = rank
      @benefits = benefits  # acquired equipment, ships / shares
    end

    def basic_training(char, first_career: false)
      if first_career
        skills = self.class::SERVICE_SKILLS
      else
        skills = [Traveller.choose("Service skill",
                                   *self.class::SERVICE_SKILLS)]
      end
      skills.each { |sym|
        unless char.skills.key?(sym)
          char.log "Acquired #{sym} 0 in Basic Training"
          char.skills[sym] = 0
        end
      }
    end

    def assignment
      @assignment ||= Traveller.choose("Choose a specialty:",
                                       *self.class::SPECIALIST_SKILLS.keys)
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

    # any skills obtained start at level 1
    def training_roll!(char)
      roll = Traveller.roll('1d6')
      choices = [:stats, :service, :specialist]
      choices << :advanced if self.class.advanced_skills?(char.stats)
      choices << :officer if self.is_a?(MilitaryCareer) and self.officer
      choice = Traveller.choose("Choose training regimen:", *choices)
      case choice
      when :stats
        stats = self.class::STATS.fetch(roll - 1)
        which_stat = stats.keys.first
        char.log "Trained #{which_stat} +1"
        char.stats.boost stats
        char.log "Trained #{which_stat} to #{char.stats.send(which_stat)}"
      when :service
        svc = self.class::SERVICE_SKILLS.fetch(roll - 1)
        char.skills[svc] ||= 0
        char.skills[svc] += 1
        char.log "Trained service skill #{svc} to #{char.skills[svc]}"
      when :specialist
        spec =
          self.class::SPECIALIST_SKILLS.fetch(self.assignment).fetch(roll - 1)
        char.skills[spec] ||= 0
        char.skills[spec] += 1
        char.log "Trained specialist skill #{spec} to #{char.skills[spec]}"
      when :advanced
        adv = self.class::ADVANCED_SKILLS.fetch(roll - 1)
        char.skills[adv] ||= 0
        char.skills[adv] += 1
        char.log "Trained advanced skill #{adv} to #{char.skills[adv]}"
      when :officer
        off = self.class::OFFICER_SKILLS.fetch(roll - 1)
        char.skills[off] ||= 0
        char.skills[off] += 1
        char.log "Trained officer skill #{off} to #{char.skills[off]}"
      end
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

    # possibly nil
    def rank_benefit
      self.class::RANKS[@rank]
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
                       :computers, :space_science, :jack_of_all_trades]

    # made up by Rick
    OFFICER_SKILLS = [:deception, :diplomat, :investigate,
                      :navigation, :recon, :stealth]
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
