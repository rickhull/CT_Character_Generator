module Presenter

  $LOAD_PATH << File.expand_path("../../lib", __FILE__)

  def Presenter.show(character, method = 'txt')
    case method
      when 'csv'
        print_colon = false
        headers.each { |hdr|
          print ":" if print_colon == true
          print_colon = true 
          print "#{character.hdr}" 
        }
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
