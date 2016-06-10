class Presenter

  def initialize(character)
    @headers = Array.new
    @headers << @rank   = character.rank
    @headers << @name   = character.name 
    @headers << @upp    = character.upp
    @headers << @morale = character.morale
  end

  def show(method = 'txt')
    case method
      when 'csv'
        @headers.each { |hdr| print "#{hdr}:" }
      when 'wiki'
        print " == "
        @headers.each { |hdr| print "#{hdr} " }
      else
        @headers.each { |hdr| print "#{hdr} " }
    end
    puts
  end

end
