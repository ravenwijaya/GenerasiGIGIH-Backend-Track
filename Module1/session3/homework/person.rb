require 'colorize'
class Person
  attr_reader :name

  def initialize(name, hitpoint, attack_damage)
    @name = name
    @hitpoint = hitpoint
    @attack_damage = attack_damage
    @alive = true
  end

  def to_s
    "#{@name}"
  end
  def print_stats
    puts "#{@name} has #{@hitpoint} hitpoint and #{@attack_damage} attack damage"
  end

  def attack(other_person)
    puts "[ATTACK]".colorize( :red ) + "  #{@name} attacks #{other_person.name} with #{@attack_damage} damage"
    other_person.take_damage(@attack_damage)
  end

  def take_damage(damage)
    @hitpoint -= damage
    if @hitpoint <= 0
      die
    end
  end
  
  def take_healing(heal_point)
    @hitpoint += heal_point
  end
  def die 
    puts "#{@name} dies".colorize( :red )
    @alive = false
  end

  def die?
    !@alive
  end
  def removed?
    die?
  end
  
end
