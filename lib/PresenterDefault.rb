module PresenterDefault

  def PresenterDefault.show(character)
    lines = Array.new
    lines[0] =  ""
    lines[0] += "#{character.title} " if character.title
    lines[0] += "#{character.rank} "  if character.rank
    lines[0] += "#{character.name} "  if character.name
    lines[0] += "#{character.gender} "  if character.gender
    lines[0] += "Age: #{character.age} "   if character.age
    lines[0] += "#{character.upp} "   if character.upp
    character.careers.each_pair do |career, terms|
      lines[0] += "#{career}: #{terms} "
    end
    lines[2] =  ""
    lines[2] += "#{character.hair} hair " if character.hair
    lines[2] += "#{character.skin} skin " if character.skin
    lines[3] =  ""
    if character.skills 
      character.skills.each_pair do |skill, level|
        lines[3] += "#{skill}-#{level} "
      end
    end
    lines[4] =  ""
    lines[4] += "Cash: #{character.stuff['cash']} " if character.stuff['cash'] > 0
    character.stuff['benefits'].each do |k,v|
      lines[4] +=  "#{k} (#{v}) "
    end

    lines.each do |line|
      puts line unless line.nil? || line.length == 0 
    end
  end
end
