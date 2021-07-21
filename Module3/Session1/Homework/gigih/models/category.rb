class Category
    attr_accessor :id, :name
    
    def initialize(id, name)
        @id = id
        @name = name
    end
end

def get_category_by_id(id)
    rawData = $client.query("select * from categories where id = '#{id}'")
    data = rawData.each[0]
    category = Category.new(data["id"], data["name"])
    category
end

def get_all_categories
    raw = $client.query("select * from categories")
    categories = Array.new
    raw.each do |data|
        category = Category.new(data["id"], data["name"])
        categories.push(category)
    end
    categories
end