module TravellerChar
  module Data
    PATH = File.expand_path(File.join(__dir__, '..', '..', 'data'))
    raise "can't find #{PATH}" unless File.directory?(PATH)
  end
end
