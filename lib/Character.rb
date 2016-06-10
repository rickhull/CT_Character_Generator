class Character


  $LOAD_PATH << File.expand_path("../../lib", __FILE__)
  $DATA_PATH = File.expand_path("../../data", __FILE__)

  require 'Traveller'
  attr_accessor :gender, :name, :skills, :age, :upp, :title,
                :career, :officer, :morale, :rank, :terms,
                :awards, :wounds

  def initialize()
    @upp      = Traveller.upp
    @gender   = Traveller.gender.capitalize
    #@name     = Traveller.name
    #attributes.each do |attr, value|
    #  setter = "#{attr}="
    #  send(setter, value) if self.respond_to?(setter)
    #end
    
  end

end


me = Character.new
puts "#{me.gender} #{me.upp}"



