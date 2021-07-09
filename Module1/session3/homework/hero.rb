require_relative 'person'
require 'colorize'

class Hero < Person
    def  initialize(name, hitpoint, attack_damage)
      super(name,hitpoint,attack_damage)
      @deflect_percentage = 0.8
      @heal_point = 20
    end
    
    def take_damage(damage)
      if rand  <= @deflect_percentage
        puts "[DEFLECT]".colorize( :green ) + " #{@name} deflects the attack."
      else
        super(damage)
      end
    end

    def heal(other_hero)
      other_hero.take_healing(@heal_point)
      puts "[HEAL]".colorize( :green ) + "    #{@name} heals #{other_hero.name}, restoring #{@heal_point} hitpoints "
    end
  end