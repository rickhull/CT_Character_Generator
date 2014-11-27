# Arrays for CT data. Needs to be pushed into JSON
# or some other real data store. 

Grade = Hash.new
Grade['Enlisted'] = %w(E1 E2 E3 E4 E5 E6 E7 E8 E9)
Grade['Officer'] = %w(O1 O2 O3 O4 O5 O6)
Ranks = Hash.new

Ranks['Marines'] = {
  'E1' => 'Private',
  'E2' => 'Lance Corporal',
  'E3' => 'Corporal',
  'E4' => 'Lance Sergeant',
  'E5' => 'Sergeant',
  'E6' => 'Leading Sergeant',
  'E7' => 'First Sergeant',
  'E8' => 'Sergeant Major',
  'O1' => 'Lieutenant',
  'O2' => 'Captain',
  'O3' => 'Force Commander',
  'O4' => 'Lieutenant Colonel',
  'O5' => 'Colonel',
  'O6' => 'Brigadier'
}


