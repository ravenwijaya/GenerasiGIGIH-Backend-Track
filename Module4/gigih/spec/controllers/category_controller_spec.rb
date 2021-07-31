require './db/db_connector.rb'
require './controllers/categorycontroller.rb'
require './models/category.rb'
require './models/item.rb'

describe CategoryController do
    before(:each) do 
        client = create_db_client
        client.query("delete from item_categories")
        client.query("delete from items")
        client.query("delete from categories")
       
        params = {
            'name' => "Sides"
        }
        @response = CategoryController.addcategory(params)
        @id = client.query("select * from categories").each[0]["id"]
    end
    describe '#addcategory' do
        context "when add category" do   
            it 'should save category' do
                expect(get_category_by_id(@id)).not_to be_nil
            end
        end
    end
    describe '#listitem' do
        context "when get list category" do
            it 'should render category page' do
                categoryid = [@id]
                categoriesonly = get_all_categories
                categories = get_all_categories(categoryid)
                itemcategory = Array.new
                for data in categories do
                    itemcategory.push(data.id)
                end
                renderer = ERB.new(File.read("./views/category.erb"))
                renderer.result(binding)
                
                expected_view = ERB.new(File.read("./views/category.erb")).result(binding)
                expect(expected_view).to eq(CategoryController.listcategory({categoriesid: [@id]}))
            end
            
        end
    end
    describe '#edit_by_id' do
        context "when edit by id" do
            it 'should render edit page' do
                id = @id
                category = get_category_by_id(id)
                expected_view = ERB.new(File.read("./views/edit_category.erb")).result(binding)
                expect(expected_view).to eq(CategoryController.edit_by_id({'id' => id}))
            end
            
        end
    end
    describe '#action_edit_by_id' do
        context "when edited by id" do
            it 'should return true' do
                params={
                    'id' => @id,
                    'name' => 'Beverage'
                }
                expect(CategoryController.action_edit_by_id(params)).to eq(true)
            end
            it 'should save category' do
                expect(get_category_by_id(@id)).not_to be_nil
            end
            
        end
    end
    describe '#delete_by_id' do
        context "when deleted" do
            before(:each) do
                @response = CategoryController.delete_by_id('id'=>@id)
            end
            it 'should return true' do
                expect(@response).to eq(true)
            end
            it 'should deleted' do
                expect(get_category_by_id(@id)).to eq(nil)
            end
            
        end
    end
end
