# require './test_helper'
require './models/category.rb'
require './models/item.rb'


describe Item do

    describe '#initialize and #valid?' do
        context "when initialized with valid input" do
            it 'should return true' do
                item = Item.new(1,"Banana",12000)
                expect(item.valid?).to eq(true)
            end
        end
    end
    describe '#save' do
        context "with valid object" do
            it 'should return true' do
                item = Item.new('id','name','price')

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("insert into items(name,price) values ('#{item.name}',#{item.price})")
            
                expect(item.save).to eq(true)
            end
        end
    end
    describe '#update' do
        context "when updated with valid input" do
            it 'should return true' do
                item = Item.new('id',"name",'price')
                category = Category.new('id', 'name')
              
                params = {
                    'newname' => 'newname',
                    'newprice' => 'price',
                    'categoryid' => [category]
                }
                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("UPDATE items SET name = '#{params['newname']}', price= #{params['newprice']} where id = #{item.id}")
                expect(mock_client).to receive(:query).with("DELETE from item_categories where item_id = #{item.id}")
                for category in params['categoryid']
                    expect(mock_client).to receive(:query).with("insert into item_categories(item_id, category_id) values ('#{item.id}','#{category.id}')")

                end
               
                expect(item.update(params['newname'],params['newprice'],params['categoryid'])).to eq(true)
            end
        end
    end
    describe '#delete' do
        context "when deleted with valid input" do
            it 'should return true' do
                item = Item.new('id',"name",'price')
                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("DELETE from item_categories where item_id = #{item.id}")
                expect(mock_client).to receive(:query).with("DELETE from items where id = #{item.id}")

                expect(item.delete).to eq(true)
            end
        end
        
    end
    # describe '.getallitems' do
    #     context "get all items" do
    #         it 'should return list items' do
    #             item = Item.new('id',"name",'price')
                
    #             category = Category.new('id', 'name')
    #             items = [item]
    #             params = {
    #                 'id' => 'id',
    #                 'dataid' => 'dataid',
    #                 'categoryid'=> 'categoryid'
    #             }
    #             mock_client = double
    #             allow(Mysql2::Client).to receive(:new).and_return(mock_client)
    #             expect(mock_client).to receive(:query).with("select id from items")
    #             expect(mock_client).to receive(:query).with("select * from items where id = '#{params['id']}'")
    #             expect(mock_client).to receive(:query).with("select * from item_categories where item_id = '#{params["dataid"]}' ")
    #             expect(mock_client).to receive(:query).with("select * from categories where id = '#{params["cadtegoryid"]}'")


    #             expect(get_category_by_id(params["categoryid"])).to eq(category)
    #             expect(get_item_by_id(params['id'])).to eq(item)
    #             expect(get_all_items).to eq(items)
    #         end
    #     end
        
    # end
 
end