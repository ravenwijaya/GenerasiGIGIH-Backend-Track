require 'colorize'
class Person
  attr_reader :name

  def initialize(name, hitpoint, attack_damage)
    @name = name
    @hitpoint = hitpoint
    @attack_damage = attack_damage
  end

  def to_s
    "#{@name} has #{@hitpoint} hitpoint and #{@attack_damage} attack damage"
  end

  def attack(other_person)
    puts "[ATTACK]".colorize( :red ) + "  #{@name} attacks #{other_person.name} with #{@attack_damage} damage"
    other_person.take_damage(@attack_damage)
  end

  def take_damage(damage)
    @hitpoint -= damage
  end

  def die?
    if @hitpoint <= 0
      puts "-----#{@name} dies-----".colorize( :red )
      true
    end
  end
  
end
