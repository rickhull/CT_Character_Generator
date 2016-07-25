module Presenter

  $LOAD_PATH << File.expand_path("../../lib", __FILE__)

  def Presenter.show(character, method = 'txt')
    case method
      when 'csv'
        require 'PresenterCSV'
        PresenterCSV.show(character)
      when 'wiki'
        print " == "
        headers.each { 
          |hdr| print "#{character[hdr]} " 
        }
      else
        require 'PresenterDefault'
        PresenterDefault.show(character)
    end
    puts
  end

end
