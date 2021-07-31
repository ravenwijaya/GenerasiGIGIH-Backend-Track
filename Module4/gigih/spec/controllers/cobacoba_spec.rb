require './db/db_connector.rb'
require './controllers/categorycontroller.rb'
require './models/category.rb'
require './models/item.rb'

describe CategoryController do
    describe '#addcategory' do
        context "when add category" do   
            it 'should save category' do
                params={
                    'name'=>'name'
                }
                
                # CategoryController = double
                # allow(CategoryController).to receive(:addcategory)
                # expect(CategoryController).to receive(:addcategory).with(params)
                # CategoryController.addcategory(params)
                # category = Category.new(nil,name)
                # category.save

                mock_category = double()
                allow(Category).to receive(:new).and_return(mock_category)
               
                expect(mock_category).to receive(:new).with(nil,params['name'])
                allow(mock_category).to receive(:save).and_return(true)
                CategoryController.addcategory(params)
               
                
                expect(CategoryController.addcategory(params)).to eq(true)

             
            end
        end
    end

end
