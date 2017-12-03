require 'traveller/character'
require 'traveller/careers'

module Traveller
  class CareerPath
    TERM_YEARS = 4

    class Ineligible < RuntimeError; end
    class CareerError < RuntimeError; end

    attr_reader :char, :careers, :active_career

    def initialize(character)
      @char = character
      @char.log "Initiated new career path"
      @careers = []
      @active_career
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
      if career.qualify_check?(@careers.size)
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
      self.basic_training
      self
    end

    def basic_training
      return unless @active_career.term.zero?
      if @careers.length.zero?
        @active_career.class::SERVICE_SKILLS
      else
        [Traveller.choose("Service skill",
                          *@active_career.class::SERVICE_SKILLS)]
      end.each { |sym|
        unless char.skills.key?(sym)
          @char.log "Acquired basic training skill: #{sym} 0"
          @char.skills[sym] = 0
        end
      }
    end

    def run_term
      raise(CareerError, "no active career") unless @active_career
      @active_career.run_term
      unless @active_career.active
        @careers << @active_career
        @active_career = nil
      end
    end

    def muster_out
      if @active_career
        raise(CareerError, "career is inactive") unless @active_career.active
        raise(CareerError, "must remain") if @active_career.must_remain?
        @char.add_stuff(@active_career.muster_out)
        @careers << @active_career
        @active_career = nil
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
