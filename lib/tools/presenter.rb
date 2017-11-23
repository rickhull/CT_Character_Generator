module Presenter

  def Presenter.show(character, method = "txt")
    case method
      when "csv"
        require "tools/presenter_csv"
        PresenterCSV.show(character)
      when "wiki"
        print " == "
        headers.each { 
          |hdr| print "#{character[hdr]} " 
        }
      else
        require "tools/presenter_default"
        PresenterDefault.show(character)
    end
    puts
  end

end
