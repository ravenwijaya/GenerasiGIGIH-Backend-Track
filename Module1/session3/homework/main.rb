require_relative 'hero'
require_relative 'mongol_archer'
require_relative 'mongol_swordsman'
require_relative 'mongol_spearman'
require_relative 'playable_character'
require_relative 'game'

jin = PlayableCharacter.new("Jin Sakai", 100, 50)
yuna = Hero.new("Yuna", 90, 45)
sensei_ishikawa = Hero.new("Sensei Ishikawa", 80, 60)
mongol_archer = MongolArcher.new("Mongol Archer", 80, 50)
mongol_spearman = MongolSpearman.new("Mongol Spearman", 120, 60)
mongol_swordsman = MongolSwordsman.new("Mongol Swordsman", 100, 50)

game = Game.new(jin)
game.add_hero(yuna)
game.add_hero(sensei_ishikawa)
game.add_villain(mongol_archer)
game.add_villain(mongol_spearman)
game.add_villain(mongol_swordsman)
game.start