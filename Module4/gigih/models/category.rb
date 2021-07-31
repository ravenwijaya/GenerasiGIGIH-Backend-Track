require './db/db_connector.rb'
class Category
    attr_accessor :id, :name, :item
    
    def initialize(id, name, item = nil)
        @id = id
        @name = name
        @item = item
    end
    def save
        
        return false unless valid?
        client = create_db_client
        client.query("INSERT into categories(name) values ('#{name}')")
        true
    end
    def update(newname)
        return false unless valid?
        client = create_db_client
        client.query("UPDATE categories SET name = '#{newname}' where id = #{id}")
        true
    end
    def delete
        return false unless valid?
        client = create_db_client
        client.query("DELETE from item_categories where category_id = #{id}")
        client.query("DELETE from categories where id = #{id}")
        true
    end
    def valid?
        return false if @name.nil? 
        true
    end
end

def get_category_by_id(id)
    client = create_db_client
    rawData = client.query("select * from categories where id = '#{id}'")
    data = rawData.each[0]
    if(!data.nil?)
    category = Category.new(data["id"], data["name"])
    category
    end
    
end
# ====

def get_all_categories(categoryid = nil)
    client = create_db_client
    rawData = categoryid.nil? ? client.query("select * from categories"): client.query("select * from categories where id in (#{categoryid.join(',')})")
    categories = Array.new
    rawData.each do | data |
        items = get_item_by_category_id(data["id"])
        category = Category.new(data["id"], data["name"], items)
        categories.push(category)
    end
    categories
end




