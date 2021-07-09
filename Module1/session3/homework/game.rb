class Game 
    def initialize(playable_character)
        @npcs = { heroes: [], villains: []}
        @playable_character = playable_character
       
    end
    def add_hero(person)
        @npcs[:heroes] << person
    end
    def add_villain(person)
        @npcs[:villains] << person
    end
    def start
        
        until (@playable_character.die? || @npcs[:villains].empty? ) do
            print_characters_stats
            play_characters_turn
        end
    end
    def print_characters_stats
        @playable_character.print_stats
        @npcs.each_value do |people|
            people.each do |person|
                person.print_stats
            end
        end
        puts "\n"
    end
    def play_characters_turn
        @playable_character.play_turn(@npcs[:heroes], @npcs[:villains])
        @npcs.each do |group, people|
            people.each do |person|
                if group ==:heroes
                    targets = @npcs[:villains]
                    unless targets.empty?
                        target = targets[rand(targets.size)]
                        person.attack(target)
                        targets.delete(target) if target.removed?
                    end
                elsif group == :villains
                    targets = @npcs[:heroes].dup
                    targets << @playable_character
                    unless targets.empty?
                        target = targets[rand(targets.size)]
                        person.attack(target)
                        @npcs[:heroes].delete(target) if target.removed?
                    end
                end
            end
            puts "\n"
        end
    end
    
end