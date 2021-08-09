require './db/db_connector.rb'
require './models/category'


class Item
    attr_reader :name, :price, :id, :category
    def initialize(id, name, price, category = nil)
        @id = id
        @name = name
        @price = price
        @category = category
    end

    def save
        return false unless valid?
        client = create_db_client
        client.query("insert into items(name,price) values ('#{name}',#{price})")
        true
    end

    def update(newname,newprice,newcategoryid)
        return false unless valid?
        client = create_db_client
        client.query("UPDATE items SET name = '#{newname}', price= #{newprice} where id = #{id}")
        client.query("DELETE from item_categories where item_id = #{id}")
        categories = newcategoryid
        for category in categories do
           
            client.query("insert into item_categories(item_id, category_id) values ('#{id}','#{category.id}')")
        end
        true
    end

    def delete
        client = create_db_client
        client.query("DELETE from item_categories where item_id = #{id}")
        client.query("DELETE from items where id = #{id}")
        true
    end

    def valid?
        return false if @name.nil? || @price.nil?
        true
    end
    
    
end

def get_all_items
    client = create_db_client
    rawData = client.query("select id from items")
    items = Array.new
    rawData.each do | data |
        items.push(get_item_by_id(data["id"]))
    end
    items
end

def get_item_by_id(id)
    client = create_db_client
    rawData = client.query("select * from items where id = '#{id}'")
    data = rawData.each[0]
    if(!data.nil?)
    rawData2 = client.query("select * from item_categories where item_id = '#{data["id"]}' ")
    categories = Array.new
    rawData2.each do | c_data |
        category = get_category_by_id(c_data["category_id"])
        categories.push(category)
    end
    
    item = Item.new(data["id"], data["name"], data["price"], categories)
    item
    end
   
  
end


def get_item_by_category_id(id)
    client = create_db_client
    rawData = client.query("select * from item_categories where category_id = '#{id}'")
    items = Array.new
    rawData.each do | data |
        items.push(get_item_by_id(data["item_id"]))
    end
    items
end

