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
    if character.skills 
      character.skills.each_pair do |skill, level|
        print "#{skill}-#{level} "
      end
    end
  end
end
