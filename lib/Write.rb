module Write

  def Write.write(c, mode)
    rank = c.rank
    name = c.name
    upp = c.upp
    gender = c.gender
    age = c.age
    terms = c.terms
    llp = c.llp
    morale = c.morale
    career = c.career
    title = c.title
   
    if mode == 'txt' 
      puts "#{career} #{title} #{rank} #{name} #{upp} Gender #{gender.capitalize} Age #{age} Terms  #{terms} Morale #{morale} LLP #{llp}"
      first_skill = true
      c.skills.each do |skill, level|
        if first_skill == false
          print ", "
        end 
        print "#{skill}-#{level}"
        first_skill = false
      end
      puts""
    elsif mode == 'hash'
      id = Hash.new
      id['name'] = name
      id['rank'] = rank
      id['upp'] = upp
      id['gender'] = gender
      id['age'] = age
      id['terms'] = terms
      id['llp'] = llp
      id['career'] = career
      id['morale'] = morale
      id['skills'] = c.skills
      id['title'] = title
      return id
    elsif mode == 'csv'
      print "#{career}:#{rank}:#{title}:#{name}:#{upp}:#{gender.capitalize}:#{age}:#{terms}:#{morale}:#{llp}:"
      c.skills.each do |skill,level|
        if first_skill == false
          print ","
        end
        print "#{skill}-#{level}"
        first_skill = false
      end
      puts

    elsif mode == 'wiki'
      puts "#{career} #{title} #{rank} #{name} #{upp} Gender #{gender.capitalize} Age #{age} Terms  #{terms} Morale #{morale} LLP #{llp}"
      puts 
      c.skills.each do |skill, level|
        if first_skill == false
          print ", "
        end 
        print "#{skill}-#{level}"
        first_skill = false
      end
      puts
      puts
    elsif mode == 'soldier'
      puts "#{rank} #{name} #{morale}"
    elsif mode == 'html'
      puts "<p>#{career} #{title} #{rank} #{name} #{upp} Gender #{gender.capitalize} Age #{age} Terms  #{terms} Morale #{morale} LLP #{llp}"
      print "<p>" 
      c.skills.each do |skill, level|
        if first_skill == false
          print ", "
        end 
        print "#{skill}-#{level}"
        first_skill = false
      end
      puts 
      puts "<br>"
    end

end

end
