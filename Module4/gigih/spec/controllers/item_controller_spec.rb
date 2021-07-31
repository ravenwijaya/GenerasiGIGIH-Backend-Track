# require './test_helper'

require './db/db_connector.rb'
require './controllers/itemcontroller.rb'
require './models/category.rb'
require './models/item.rb'

describe ItemController do
    before(:each) do 
        client = create_db_client
        client.query("delete from item_categories")
        client.query("delete from items")
        client.query("delete from categories")
       
        params = {
            'name' => "Mie ayam",
            'price' => "20000"
        }
        @response = ItemController.additem(params)
        @id = client.query("select * from items").each[0]["id"]
    end
    describe '#additem' do
        context "when add item" do   
            it 'should save items' do
                expect(get_item_by_id(@id)).not_to be_nil
            end
        end
    end
    describe '#listitem' do
        context "when get list item" do
            it 'should render items page' do
                items = get_all_items
                listcategories = Hash.new
                for item in items do
                categoryarr = Array.new
                    for value in item.category do
                    categoryarr.push(value.name)
                    end
                listcategories["#{item.id}"] = categoryarr.join(", ")
                end
                
                expected_view = ERB.new(File.read("./views/index.erb")).result(binding)
                expect(expected_view).to eq(ItemController.listitem)
            end
            
        end
    end
    describe '#show_by_id' do
        context "when  show by id" do
            it 'should render show page' do
                item = get_item_by_id(@id)
                categoryarr = Array.new
                for value in item.category do
                    categoryarr.push(value.name)
                end
                listcategories = categoryarr.join(", ")
                
                expected_view = ERB.new(File.read("./views/show_item.erb")).result(binding)
                expect(expected_view).to eq(ItemController.show_by_id({'id' => @id}))
            end
            
        end
    end
    describe '#edit_by_id' do
        context "when edit by id" do
            it 'should render edit page' do
                item = get_item_by_id(@id)
                categoryarr = Array.new
                for value in item.category do
                    categoryarr.push(value.name)
                end
                listcategories = categoryarr.join(", ")
                
                expected_view = ERB.new(File.read("./views/show_item.erb")).result(binding)
                expect(expected_view).to eq(ItemController.show_by_id({'id' => @id}))
            end
            
        end
    end
    describe '#action_edit_by_id' do
        context "when edited by id" do
            it 'should return true' do
                category = Category.new("id","Fruits")
                category.save
                client=create_db_client
                category1 = client.query("select * from categories").each[0]["id"]
                params = {
                    'id'=>@id,
                    'name'=>"melon",
                    'price'=>"12000",
                    categoryid:[category1]
                }
                
                expect(ItemController.action_edit_by_id(params)).to eq(true)
            end  
        end
    end
    describe '#delete_by_id' do
        before(:each) do
            @response = ItemController.delete_by_id({'id'=>@id})
        end
        context "when deleted" do
            it 'should return true' do
                expect(@response).to eq(true)
            end
            it 'should deleted' do
                expect(get_item_by_id(@id)).to eq(nil)
            end
            
        end
    end
    
end
