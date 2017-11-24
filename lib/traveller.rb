module Traveller
  ROLL_RGX = %r{
    \A    # starts with
    (\d*) # 0 or more digits; dice count
    [dD]  # character d
    (\d+) # 1 or more digits; face count
    \z    # end str
  }x

  def self.roll(str = nil, faces: 6, dice: 2, count: 1)
    return self.roll_str(str) if str
    rolln = -> (faces, dice) { Array.new(dice) { rand(faces) + 1 } }
    (Array.new(count) { rolln.(faces, dice).sum }.sum.to_f / count).round
  end

  def self.roll_str(str)
    matches = str.match(ROLL_RGX) or raise("bad roll: #{str}")
    dice, faces = matches[1], matches[2]
    self.roll(dice: dice.empty? ? 1 : dice.to_i, faces: faces.to_i)
  end
end
