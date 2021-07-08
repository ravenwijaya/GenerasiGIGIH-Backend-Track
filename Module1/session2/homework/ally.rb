require_relative 'person'

class Ally < Person
    def get_heal(heal)
        @hitpoint += heal
    end
end