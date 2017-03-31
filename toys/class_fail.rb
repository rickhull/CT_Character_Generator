class Career
  def update_character()
    puts @skill_options.class
  end
end

class Firster < Career
  def initialize
    @skill_options = ["Recon", "Vehicle"]
  end
end

fred = Firster.new
fred.update_character()

# Ruby 2.4.0
# Output
# NilClass

