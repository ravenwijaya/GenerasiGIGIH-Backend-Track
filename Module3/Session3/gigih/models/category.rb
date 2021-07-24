class Category
    attr_accessor :id, :name, :item
    
    def initialize(id, name, item = nil)
        @id = id
        @name = name
        @item = item
    end
    def save
        $client.query("INSERT into categories(name) values ('#{name}')")
    end
    def update(newname)
        $client.query("UPDATE categories SET name = '#{newname}' where id = #{id}")
    end
    def delete
        $client.query("DELETE from item_categories where category_id = #{id}")
        $client.query("DELETE from categories where id = #{id}")
    end
end

def get_category_by_id(id)
    rawData = $client.query("select * from categories where id = '#{id}'")
    data = rawData.each[0]
    category = Category.new(data["id"], data["name"])
    category
end
# ====

def get_all_categories(categoryid = nil)
    rawData = categoryid.nil? ? $client.query("select * from categories"): $client.query("select * from categories where id in (#{categoryid.join(',')})")
    categories = Array.new
    rawData.each do | data |
        items = get_item_by_category_id(data["id"])
        category = Category.new(data["id"], data["name"], items)
        categories.push(category)
    end
    categories
end




