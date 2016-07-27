$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'Presenter'
require 'CharacterTools'

character = CharacterTools.init
character.name      = "Marco Domici"
character.upp       = "79AA8B" 
character.skills    = {'GunCbt' => 1, 'VaccSuit' => 1}
character.careers   = {'Marine' => 2, 'Noble' => 1}
Presenter.show(character)
Presenter.show(character, 'csv')
#Presenter.show(character, 'wiki')
