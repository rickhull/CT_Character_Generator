class Character

  #$LOAD_PATH << File.expand_path("../../lib", __FILE__)
  #$DATA_PATH = File.expand_path("../../data", __FILE__)

  attr_accessor :gender, :name, :skills, :age, :upp, :llp, :title,
                :career, :officer, :morale, :title, :rank, :terms,
                :dragon_rank, :awards, :wounds

  def initialize( attributes = {})
    attributes.each do |attr, value|
      setter = "#{attr}="
      send(setter, value) if self.respond_to?(setter)
    end
  end

end
