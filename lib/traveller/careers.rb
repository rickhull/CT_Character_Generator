module Traveller
  class Career
    class Error < RuntimeError; end
    class UnknownAssignment < Error; end
    class MusterError < Error; end

    def self.advanced_skills?(stats)
      stats.education >= 8
    end

    TERM_YEARS = 4

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

    def initialize(char, assignment: nil, term: 0, active: false, rank: 0,
                   benefits: {})
      @char = char
      @assignment = assignment
      if @assignment and !self.class::SPECIALIST_SKILLS.key?(@assignment)
        raise(UnknownAssignment, assignment.inspect)
      end

      # career tracking
      @term = term
      @active = active
      @rank = rank
      @benefits = benefits  # acquired equipment, ships / shares
      @term_mandate = nil
    end

    def assignment
      @assignment ||= Traveller.choose("Choose a specialty:",
                                       *self.class::SPECIALIST_SKILLS.keys)
    end

    def qualify_check?(career_count, dm: 0)
      dm += -1 * career_count
      roll = Traveller.roll('2d6')
      puts format("Qualify check: roll %i (DM %i) against %i",
                  roll, dm, self.class::QUALIFY_CHECK)
      (roll + dm) >= self.class::QUALIFY_CHECK
    end

    def survival_check?(dm: 0)
      roll = Traveller.roll('2d6')
      puts format("Survival check: roll %i (DM %i) against %i",
                  roll, dm, self.class::SURVIVAL_CHECK)
      (roll + dm) >= self.class::SURVIVAL_CHECK
    end

    def advancement_check?(roll: nil, dm: 0)
      roll ||= Traveller.roll('2d6')
      puts format("Advancement check roll: %i (DM %i) against %i",
                  roll, dm, self.class::ADVANCEMENT_CHECK)
      (roll + dm) >= self.class::ADVANCEMENT_CHECK
    end

    # any skills obtained start at level 1
    def training_roll
      roll = Traveller.roll('d6')
      @char.log "Training roll (d6): #{roll}"
      choices = [:stats, :service, :specialist]
      choices << :advanced if self.class.advanced_skills?(@char.stats)
      choices << :officer if self.is_a?(MilitaryCareer) and self.officer
      choice = Traveller.choose("Choose training regimen:", *choices)
      case choice
      when :stats
        stats = self.class::STATS.fetch(roll - 1)
        which_stat = stats.keys.first
        @char.stats.boost stats
        @char.log "Trained #{which_stat} to #{@char.stats.send(which_stat)}"
      when :service
        svc = self.class::SERVICE_SKILLS.fetch(roll - 1)
        @char.skills[svc] ||= 0
        @char.skills[svc] += 1
        @char.log "Trained service skill #{svc} to #{@char.skills[svc]}"
      when :specialist
        spec =
          self.class::SPECIALIST_SKILLS.fetch(self.assignment).fetch(roll - 1)
        @char.skills[spec] ||= 0
        @char.skills[spec] += 1
        @char.log "Trained #{@assignment} specialist skill #{spec} " +
                  "to #{@char.skills[spec]}"
      when :advanced
        adv = self.class::ADVANCED_SKILLS.fetch(roll - 1)
        @char.skills[adv] ||= 0
        @char.skills[adv] += 1
        @char.log "Trained advanced skill #{adv} to #{@char.skills[adv]}"
      when :officer
        off = self.class::OFFICER_SKILLS.fetch(roll - 1)
        @char.skills[off] ||= 0
        @char.skills[off] += 1
        @char.log "Trained officer skill #{off} to #{@char.skills[off]}"
      end
    end

    def event_roll(dm: 0)
      roll = Traveller.roll('2d6')
      clamped = (roll + dm).clamp(2, 12)
      @char.log "Event roll (2d6): #{roll} + DM #{dm} = #{clamped}"
      @char.log self.class::EVENTS.fetch(clamped)
      # TODO: actually perform the event stuff
    end

    def mishap_roll
      roll = Traveller.roll('d6')
      @char.log "Mishap roll (d6): #{roll}"
      @char.log self.class::MISHAPS.fetch(roll)
      # TODO: actually perform the mishap stuff
    end

    def cash_roll(dm: 0)
      roll = Traveller.roll('2d6')
      clamped = (roll + dm).clamp(2, 12)
      amount = self.class::CASH.fetch(clamped)
      puts "Cash roll: #{roll} (DM #{dm}) = #{clamped} for #{amount}"
      amount
    end

    def advance_rank
      @rank += 1
      @char.log "Advanced career to rank #{@rank}"
      title, skill, level = self.rank_benefit
      if title
        @char.log "Awarded rank title: #{title}"
        @char.log "Achieved rank skill: #{skill} #{level}"
        @char.skills[skill] ||= 0
        @char.skills[skill] = level if level > @char.skills[skill]
      end
    end

    def must_remain?
      @term_mandate == :must_remain
    end

    def must_exit?
      @term_mandate == :must_exit
    end

    def run_term
      raise(Error, "career is inactive") unless @active
      raise(Error, "must exit") if self.must_exit?
      @term += 1
      @char.log format("%s term %i started, age %i",
                       self.name, @term, @char.age)
      self.training_roll

      if self.survival_check?
        @char.log format("%s term %i was successful", self.name, @term)
        @char.age TERM_YEARS

        self.commission_roll if self.respond_to?(:commission_roll)

        adv_roll = Traveller.roll('2d6')
        # TODO: DM?
        if self.advancement_check?(roll: adv_roll)
          self.advance_rank
          self.training_roll
        end
        if adv_roll <= @term
          @term_mandate = :must_exit
        elsif adv_roll == 12
          @term_mandate = :must_remain
        else
          @term_mandate = nil
        end

        self.event_roll
      else
        @char.log "#{self.name} career ended with a mishap!"
        @char.age rand(TERM_YEARS) + 1
        self.mishap_roll
        @active = false
      end
    end

    def retirement_benefit
      @term >= 5 ? @term * 2000 : 0
    end

    def muster_out(dm: 0)
      if @active
        raise(MusterError, "career has not started") unless @term > 0
        @active = false
        cash_benefit = 0
        @char.log "Muster out: #{self.name}"
        dm += @char.skill_check?(:gambler, 1) ? 1 : 0
        @term.clamp(0, 3).times {
          cash_benefit += self.cash_roll(dm: dm)
        }
        @char.log "Cash benefit: #{cash_benefit}"
        @char.log "Retirement benefit: #{self.retirement_benefit}"
        @benefits[:cash] ||= 0
        @benefits[:cash] += cash_benefit + self.retirement_benefit
        @benefits
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

    def commission_roll(dm: 0)
      return if @officer
      if Traveller.choose("Apply for commission?", :yes, :no) == :yes
        if self.commission_check?
          @char.log "Became an officer!"
          self.commission!
        else
          @char.log "Commission application was rejected"
        end
      end
    end

    def commission_check?(dm = 0)
     (Traveller.roll('2d6') + dm) >= self.class::COMMISSION_CHECK
    end

    def commission!
      @officer = true
      @officer_rank = 1
    end

    def rank
      @officer ? @officer_rank : @rank
    end

    def rank_benefit
      @officer ? self.class::OFFICER_RANKS[@officer_rank] : super
    end

    def advance_rank
      return super unless @officer
      @officer_rank += 1
      @char.log "Advanced career to officer rank #{@officer_rank}"
      title, skill, level = self.rank_benefit
      if title
        @char.log "Awarded officer rank title: #{title}"
        @char.log "Achieved officer rank skill: #{skill} #{level}"
        @char.skills[skill] ||= 0
        @char.skills[skill] = level if level > @char.skills[skill]
      end
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

    EVENTS = {
      2 => 'Disaster! Roll on the mishap table but you are not ejected ' +
           'from career.',
      3 => 'Ambush! Choose Pilot 8+ to escape or Persuade 10+ to bargain. ' +
           'Gain an Enemy either way',
      4 => 'Survey an alien world.  Choose Animals, Survival, Recon, or ' +
           'Life Sciences 1',
      5 => 'You perform an exemplary service.  Gain a benefit roll with +1 DM',
      6 => 'You spend several years exploring the star system; ' +
           'Choose Atrogation, Navigation, Pilot (small craft) or Mechanic 1',
      7 => 'Life event.  Roll on the Life Events table',
      8 => 'Gathered intelligence on an alien race.  Roll Sensors 8+ or ' +
           'Deception 8+.  Gain an ally in the Imperium and +2 DM to your ' +
           'next Advancement roll on success.  Roll on the mishap table on ' +
           'failure, but you are not ejected from career.',
      9 => 'You rescue disaster survivors.  Roll either Medic 8+ or ' +
           'Engineer 8+.  Gain a Contact and +2 DM on next Advancement roll ' +
           'or else gain an Enemy',
      10 => 'You spend a great deal of time on the fringes of known space. ' +
            'Roll Survival 8+ or Pilot 8+.  Gain a Contact in an alien race ' +
            'and one level in any skill, or else roll on the Mishap table.',
      11 => 'You serve as a courier for an important message for the ' +
            'Imperium.  Gain one level of diplomat or take +4 DM to your ' +
            'next Advancement roll.',
      12 => 'You make an important discovery for the Imperium.  Gain a ' +
            'career rank.',
    }

    MISHAPS = {
      1 => 'Severely injured in action.  Roll twice on the Injury table ' +
           'or take a level 2 Injury.',
      2 => 'Suffer psychological damage. Reduce Intelligence or Social ' +
           'Standing by 1',
      3 => 'Your ship is damaged, and you have to hitch a ride back to ' +
           'your nearest scout base.  Gain 1d6 Contacts and 1d3 Enemies.',
      4 => 'You inadvertently cause a conflict between the Imperium and ' +
           'a minor world or race.  Gain a Rival and Diplomat 1.',
      5 => 'You have no idea what happened to you.  Your ship was found ' +
           'drifting on the fringes of friendly space',
      6 => 'Injured.  Roll on the Injury table.',
    }

    # not defined at http://www.traveller-srd.com/core-rules/careers/ :(
    BENEFITS = {}

    def qualify_check?(career_count, stats)
      dm = stats.intelligence - career_count
      (Traveller.roll('2d6') + dm) >= 5
    end
  end
end
