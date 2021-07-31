require './models/category'
require './models/item'
class CategoryController
    def self.listcategory(params)
        categoryid = params[:categoryid]
        categoriesonly = get_all_categories
        categories = get_all_categories(categoryid)
        itemcategory = Array.new
        for data in categories do
            itemcategory.push(data.id)
        end
        renderer = ERB.new(File.read("./views/category.erb"))
        renderer.result(binding)
    end
    def self.addcategory(params)
        name = params['name']
        category = Category.new(nil,name)
        category.save
    end
    def self.edit_by_id(params)
        id = params['id']
        category = get_category_by_id(id)
        renderer = ERB.new(File.read("./views/edit_category.erb"))
        renderer.result(binding)
    end
    def self.action_edit_by_id(params)
        id = params['id']
        name = params['name']
        category = get_category_by_id(id)
        category.update(name)
    end
    def self.delete_by_id(params)
        id = params['id']
        category = get_category_by_id(id)
        category.delete
    end
end