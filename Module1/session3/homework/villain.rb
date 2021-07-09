require_relative 'person'
require 'colorize'

class Villain < Person
    def initialize(name, hitpoint, attack_damage)
        super(name, hitpoint, attack_damage)
        @flee_percentage = 0.2
        @fled = false
    end
    def take_damage(damage)
        super(damage)
        if @hitpoint <= 50 && !die?
            flee if rand < @flee_percentage
        end
    end
    def flee
        @fled = true
        puts "[FLED]".colorize( :yellow ) + "    #{@name} has fled the battlefield with #{@hitpoint} hitpoint left"
    end
    def flee?
        @fled
    end
    def removed?
        die? ||  flee?
    end
end