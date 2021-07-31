# require './test_helper'
require './models/category.rb'



describe Category do

    describe '#initialize and #valid?' do
        context "when initialized with valid input with all attributes" do
            it 'should return true' do
                category = Category.new("id","name","items")
                expect(category.valid?).to eq(true)
            end
        end

        context "with no items" do
            it 'should return true' do
                category = Category.new("id","name",nil)
                expect(category.valid?).to eq(true)
            end
        end
    end
    describe '#save' do
        context "with valid object" do
            it 'should return true' do
                category = Category.new("id","name","items")

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("INSERT into categories(name) values ('#{category.name}')")
            
                expect(category.save).to eq(true)
            end
        end
    end
    describe '#update' do
        context "when updated with valid input" do
            it 'should return true' do
                category = Category.new('id', 'name')
              
                params = {
                    'newname' => 'newname'
                }
                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("UPDATE categories SET name = '#{params['newname']}' where id = #{category.id}")
               
               
                expect(category.update(params['newname'])).to eq(true)
            end
        end
    end
    describe '#delete' do
        context "when deleted with valid input" do
            it 'should return true' do
                category = Category.new('id', 'name')
                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("DELETE from item_categories where category_id = #{category.id}")
                expect(mock_client).to receive(:query).with("DELETE from categories where id = #{category.id}")

                expect(category.delete).to eq(true)
            end
        end
        
    end
    # describe '.get_category_by_id' do
    #     context "when get category by id" do
    #         it 'should return category by id' do
    #             category = Category.new('id', 'name')
    #             mock_client = double
    #             allow(Mysql2::Client).to receive(:new).and_return(mock_client)
    #             expect(mock_client).to receive(:query).with("select * from categories where id = '#{category.id}'")
    #             rawData = double
    #             expect(rawData).to receive(:each).with(category)
    #             expect(get_category_by_id(category.id)).to eq(category)
    #         end
    #     end
    
    # end
end