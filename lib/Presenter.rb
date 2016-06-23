module Presenter

  def Presenter.show(character, method = 'txt')
    headers = Array.new
    headers <<  character.name 
    headers <<  character.upp
    headers <<  character.age
    headers <<  character.gender
    case method
      when 'csv'
        print_colon = false
        headers.each { |hdr|
          print ":" if print_colon == true
          print_colon = true 
          print "#{hdr}" 
        }
      when 'wiki'
        print " == "
        headers.each { 
          |hdr| print "#{hdr} " 
        }
      else
        headers.each { 
          |hdr| print "#{hdr} " 
        }
    end
    puts
  end

end
