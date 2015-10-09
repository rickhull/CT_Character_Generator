class Presenter

  def initialize(soldier)
    @headers = Array.new
    @headers << @rank   = soldier.rank
    @headers << @name   = soldier.name 
    @headers << @upp    = soldier.upp
    @headers << @morale = soldier.morale
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
