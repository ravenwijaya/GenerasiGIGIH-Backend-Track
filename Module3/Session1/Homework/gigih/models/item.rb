require_relative '../db/db_connector'
require_relative './category.rb'
$client = create_db_client

class Item
    attr_reader :name, :price, :id, :category
    def initialize(id, name, price, category = nil)
        @id = id
        @name = name
        @price = price
        @category = category
    end

    def save
        $client.query("insert into items(name,price) values ('#{name}',#{price})")
    end

    def update(newname,newprice,newcategoryid)
        $client.query("UPDATE items SET name = '#{newname}', price= #{newprice} where id = #{id}")
        $client.query("DELETE from item_categories where item_id = #{id}")
        categories = newcategoryid
        for category in categories do
            puts "insert into item_categories(item_id, category_id) values ('#{id}','#{category.id}')"
            $client.query("insert into item_categories(item_id, category_id) values ('#{id}','#{category.id}')")
        end
    end

    def delete
        $client.query("DELETE from item_categories where item_id = #{id}")
        $client.query("DELETE from items where id = #{id}")
    end
end

def get_all_items
    rawData = $client.query("select id from items")
    items = Array.new
    rawData.each do | data |
        items.push(get_item_by_id(data["id"]))
    end
    items
end

def get_item_by_id(id)
    rawData = $client.query("select * from items where id = '#{id}'")
    data = rawData.each[0]
    rawData2 = $client.query("select * from item_categories where item_id = '#{data["id"]}' ")
    categories = Array.new
    rawData2.each do | c_data |
        category = get_category_by_id(c_data["category_id"])
        categories.push(category)
    end
    item = Item.new(data["id"], data["name"], data["price"], categories)
    item
end
