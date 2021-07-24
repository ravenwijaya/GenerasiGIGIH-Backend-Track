require_relative '../models/order'
class Order
    def self.listorder
        orders = get_all_orders
        renderer = ERB.new(File.read("../gigih/views/index.erb"))
        renderer.result(binding)
    end
    
end