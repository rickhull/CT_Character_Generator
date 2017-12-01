require 'traveller/character'
require 'traveller/careers'

module Traveller
  class CareerPath
    TERM_YEARS = 4

    class Ineligible < RuntimeError; end
    class CareerError < RuntimeError; end

    attr_reader :char, :careers, :active_career, :must_exit, :must_remain

    def initialize(character)
      @char = character
      @char.log "Initiated new career path"
      @careers = []
      @active_career
      @must_exit = false
      @must_remain = false
    end

    def eligible?(career)
      case career
      when Traveller::Career
        return false if career.active
        cls = career.class
      when String
        cls = Traveller.career_class(career)
      end
      !@careers.any? { |c| c.class == cls }
    end

    def apply(career)
      raise(Ineligible, career.name) unless self.eligible?(career)
      if career.qualify_check?(@careers.size, @char.stats)
        @char.log "Qualified for #{career.name}"
        self.enter(career)
      else
        @char.log "Did not qualify for #{career.name}"
      end
    end

    def enter(career)
      raise(Ineligible, career.name) unless self.eligible?(career)
      raise(CareerError, "career is already active") if career.active
      raise(CareerError, "career has already started") unless career.term == 0
      self.muster_out
      @char.log "Entering new career: #{career.name}"
      @active_career = career
      @active_career.active = true
      @active_career.basic_training(@char, first_career: @careers.length.zero?)
      self
    end

    def run_term
      raise(CareerError, "no active career") unless @active_career
      raise(CareerError, "career is inactive") unless @active_career.active

      @active_career.term += 1
      @char.log format("%s term %i started, age %i",
                       @active_career.name, @active_career.term, @char.age)

      # TODO: Consider DMs?

      if @active_career.survival_check?
        @char.log format("%s term %i was successful",
                         @active_career.name, @active_career.term)
        @char.age TERM_YEARS
        @active_career.training_roll!(@char)

        if @active_career.is_a?(MilitaryCareer)
          if !@active_career.officer
            if Traveller.choose("Apply for commission?", :yes, :no) == :yes
              if @active_career.commission_check?
                @char.log "Became an officer!"
                @active_career.commission!
              else
                @char.log "Commission application was rejected"
              end
            end
          end
          # @active_career.officer_skill_roll!(@char) if @active_career.officer
        end

        adv_roll = Traveller.roll('2d6')
        if adv_roll > @active_career.class::ADVANCEMENT_CHECK
          @active_career.rank += 1
          @char.log "Advanced career to rank #{@active_career.rank}"
          title, skill, level = @active_career.rank_benefit
          if title
            @char.log "Awarded rank title: #{title}"
            @char.log "Achieved rank skill: #{skill} #{level}"
            @char.skills[skill] ||= 0
            @char.skills[skill] = level if level > @char.skills[skill]
          end
          @active_career.training_roll!(@char)
        end
        if adv_roll <= @active_career.term
          @must_exit = true
        elsif adv_roll == 12
          @must_remain = true
        end
      else
        @char.log "#{@active_career.name} career ended with a mishap!"
        @char.age rand(TERM_YEARS) + 1
        # exit career
        @active_career.mishap_roll
        @active_career.active = false
        @careers << @active_career
        @active_career = nil
      end
    end

    def muster_out
      if @active_career
        raise(CareerError, "career is inactive") unless @active_career.active
        @char.log "Muster out: #{@active_career.name}"
        dm = @char.skill_check?(:gambler, 1) ? 1 : 0
        total_cash_benefits = @active_career.muster_out(dm)
        other_benefits = @active_career.benefits
        @careers << @active_career
        @active_career = nil
        @char.log "Total cash benefits: #{total_cash_benefits}"
        @char.log "Other benefits: #{other_benefits}"
        [total_cash_benefits, other_benefits]
      end
    end

    def draft_term
      @char.log "Drafted! (fake)"
    end

    def drifter_term
      @char.log "Became a drifter (fake)"
    end
  end
end
