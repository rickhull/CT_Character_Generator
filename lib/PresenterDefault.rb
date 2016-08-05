module PresenterDefault


  def PresenterDefault.show(character)
    print "#{character.title} " if character.title
    print "#{character.rank} " if character.rank
    print "#{character.name} "
    print "#{character.upp} "
    print "#{character.age} "
    character.careers.each_pair do |career, terms|
      print " #{career}: #{terms} "
    end
    puts
    puts "#{character.hair} hair and #{character.skin} skin."
    if character.skills 
      character.skills.each_pair do |skill, level|
        print "#{skill}-#{level} "
      end
      puts
    end
    print "Cash: #{character.stuff['cash']} " if character.stuff['cash'] > 0
    character.stuff['benefits'].each do |k,v|
      print "#{k} (#{v}) "
    end
    puts
  end
end
