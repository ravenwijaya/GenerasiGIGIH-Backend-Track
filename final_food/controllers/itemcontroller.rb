require './models/item.rb'

class ItemController
    
    def self.listitem
        items = get_all_items
        listcategories = Hash.new
        for item in items do
            categoryarr = Array.new
            for value in item.category do
                categoryarr.push(value.name)
            end
            listcategories["#{item.id}"] = categoryarr.join(", ")
        end
        renderer = ERB.new(File.read("./views/index.erb"))
        renderer.result(binding)
    end

    def self.additem(params)
        name = params['name']
        price = params['price']
        item = Item.new(nil,name,price,nil)
        item.save
        
    end

    def self.show_by_id(params)
        id = params['id']
        item = get_item_by_id(id)
        categoryarr = Array.new
        for value in item.category do
            categoryarr.push(value.name)
        end
        listcategories = categoryarr.join(", ")
        renderer = ERB.new(File.read("./views/show_item.erb"))
        renderer.result(binding)
    end

    def self.edit_by_id(params)
        categories = get_all_categories
        id = params['id']
        item = get_item_by_id(id)
        itemcategory = Array.new
        for data in item.category do
            itemcategory.push(data.id)
        end
        renderer = ERB.new(File.read("./views/edit_item.erb"))
        renderer.result(binding)
    end

    def self.action_edit_by_id(params)
        id = params['id']
        name = params['name']
        price = params['price']
        categoryid = params[:categoryid]
       
        categoryarr = Array.new
        for dataid in categoryid do
            category= get_category_by_id(dataid)
            categoryarr.push(category)
        end
        item = get_item_by_id(id)
        item.update(name,price,categoryarr)
    end

    def self.delete_by_id(params)
        id = params['id']
        item = get_item_by_id(id)
        item.delete
    end
  
        
end