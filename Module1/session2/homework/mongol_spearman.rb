require_relative 'villain'

class MongolSpearman < Villain
    def attack(other_person)
        puts "[ATTACK]".colorize( :red ) + "  #{@name} thrust #{other_person.name} with #{@attack_damage} damage"
        other_person.take_damage(@attack_damage)
    end
end
