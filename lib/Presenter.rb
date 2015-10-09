class Presenter

  def initialize(soldier)
    @headers = Array.new
    @rank   = soldier.rank
    @headers << @rank
    @name   = soldier.name 
    @headers << @name
    @upp    = soldier.upp
    @headers << @upp
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
