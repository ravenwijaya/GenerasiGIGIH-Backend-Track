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
      puts "#{@name} attacks #{other_person.name} with #{@attack_damage} damage"
      if other_person.name == "Jin Sakai"
        random_number = Random.new
        if random_number.rand(1..100)  <= 80
          puts "#{other_person.name} deflects the attack."
        else
          other_person.take_damage(@attack_damage)
        end
      else
        other_person.take_damage(@attack_damage)
      end
    end

    def take_damage(damage)
      @hitpoint -= damage
    end
    def die?
      if @hitpoint <= 0
        puts "#{@name} dies"
        true
      end
    end
  end



