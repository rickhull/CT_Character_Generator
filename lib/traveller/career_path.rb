require 'traveller/character'
require 'traveller/careers'

module Traveller
  class CareerPath
    class Ineligible < RuntimeError; end
    class CareerError < RuntimeError; end

    attr_reader :char, :careers, :active_career, :must_exit, :must_remain

    def initialize(character)
      @char = character
      @careers = []
      @active_career
      @must_exit = false
      @must_remain = false
    end

    def eligible?(career)
      return false if career.active
      !@careers.any? { |c| c.class == career.class }
    end

    def apply(career)
      raise(Ineligible, career.class.name) unless self.eligible?(career)
      self.enter(career) if career.qualify_check?(@careers.size, @char.stats)
    end

    def enter(career)
      raise(Ineligible, career.class.name) unless self.eligible?(career)
      raise(CareerError, "career is already active") if career.active
      raise(CareerError, "career has already started") unless career.term == 0
      self.muster_out
      @active_career = career
      @active_career.active = true
      @active_career.basic_training(first_career: @careers.length.zero?)
      self
    end

    def run_term
      raise(CareerError, "no active career") unless @active_career
      raise(CareerError, "career is inactive") unless @active_career.active

      @active_career.term += 1
      @char.desc.age += 4

      # TODO: Consider DMs?

      if @active_career.survival_check?
        self.training_roll

        if @active_career.is_a?(MilitaryCareer)
          if !@active_career.officer
            if Traveller.choose("Apply for commission?", :yes, :no) == :yes
              if @active_career.commission_check?
                puts "#{@char.desc.name} became an Officer!"
                @active_career.commission!
              end
            end
          end
          @active_career.officer_skill_roll! if @active_career.officer
        end

        adv_roll = Traveller.roll('2d6')
        if adv_roll > @active_career.class::ADVANCEMENT_CHECK
          puts "Advancement achieved!"
          @active_career.rank += 1
          # make sure to accumulate rank benefits
          self.training_roll
        end
        if adv_roll <= @active_career.term
          puts "must exit career after this term"
          @must_exit = true
        elsif adv_roll == 12
          puts "must remain in career after this term"
          @must_remain = true
        end
      else
        puts "survival check failed"
        # exit career
        self.mishap_roll
        @active_career.active = false
        @careers << @active_career
        @active_career = nil
      end

      self
    end

    def training_roll
      advanced = @active_career.class.advanced_skills?(@char.stats)
      @active_career.training_roll!(advanced: advanced)
    end

    def term_event_roll
      @active_career.event_roll
      # TODO
    end

    def mishap_roll
      @active_career.mishap_roll
      # TODO
    end

    def muster_out
      if @active_career
        raise(CareerError, "career is inactive") unless @active_career.active
        dm = @char.skills[:gambler] >= 1 ? 1 : 0
        total_cash_benefits = @active_career.muster_out(dm)
        other_benefits = @active_career.benefits
        @careers << @active_career
        @active_career = nil
        [total_cash_benefits, other_benefits]
      end
    end

    def draft_term
      puts "fake draft"
    end

    def drifter_term
      puts "fake drifter"
    end
  end
end
