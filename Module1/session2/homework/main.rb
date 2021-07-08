require_relative 'hero'
require_relative 'ally'
require_relative 'mongol_archer'
require_relative 'mongol_swordsman'
require_relative 'mongol_spearman'

jin = Hero.new("Jin Sakai", 100, 50)
yuna = Ally.new("Yuna", 90, 45)
sensei_ishikawa = Ally.new("Sensei Ishikawa", 80, 60)
mongol_archer = MongolArcher.new("Mongol Archer", 80, 50)
mongol_spearman = MongolSpearman.new("Mongol Spearman", 120, 60)
mongol_swordsman = MongolSwordsman.new("Mongol Swordsman", 100, 50)
 
allies = [yuna, sensei_ishikawa]
allies_and_hero = [jin] + allies 
villains = [mongol_archer, mongol_spearman, mongol_swordsman]
i = 1
until (jin.die? || villains.empty? ) do
    puts "========== Turn #{i} ==========" 
    puts "\n"

    # Player Information
    puts jin
    allies.each do |ally|
        puts ally
    end
    villains.each do |villain|
        puts villain
    end
    puts "\n"
    
    # Menu
    puts "As Jin Sakai, what do you want to do this turn?"
    puts "1) Attack an Enemy"
    puts "2) Heal an Ally"    
    print "Enter option: "
    option = gets.chomp().to_i 
    puts "\n"
    case option
    when 1
        puts "Which enemy you want to attack?"
        villains.each_with_index do |villain, index|
            puts "#{index+1}) #{villain.name}"
        end
        print "Enter option: "
        option = gets.chomp().to_i - 1
        puts "\n"
        # Jin attack villain and delete villain if villain die or flee 
        jin.attack(villains[option])
        villains.each do |villain|
            villains.delete(villain) if villain.die? || villain.flee?
        end
        
    when 2
        if allies.empty?
            puts "all allies are dead"
        else
            puts "Which ally you want to heal?"
            allies.each_with_index do |ally, index|
            puts "#{index+1}) #{ally.name}"
            end
            print "Enter option: "
            option = gets.chomp().to_i - 1
            puts "\n"
            # Jin heal an ally
            jin.heal(allies[option])
        end  
    else 
        puts "Jin doesn't attack or heal his Allies this turn"
    end

    # Each allies attack a villain and delete villain if villain die or flee
    allies.each do |ally|
        ally.attack(villains[rand(villains.size)]) if !villains.empty?
        villains.each do |villain|
            villains.delete(villain) if villain.die? || villain.flee?
        end
    end

    # Each villain attack jin or jin allies and delete if die 
    villains.each do |villain|
        villain.attack(allies_and_hero[rand(allies_and_hero.size)])
        allies_and_hero.each do |ally|
            if ally.die?
                allies_and_hero.delete(ally)
                allies.delete(ally)
            end
        end
    end
    puts "\n"
    i += 1
end
