require_relative '../db/db_connector.rb'
require_relative './category.rb'
$client = create_db_client

class Order
    attr_accessor :reference_no, :customer_name, :date, :items
    def initialize(param)
        @reference_no = param[:reference_no]
        @customer_name = param[:customer_name]
        @date = param[:date]
        @items = []
    end
    def save
        return false unless valid?
        $client.query("insert into orders(reference_no, customer_name, date) 
        values ('#{reference_no}','#{customer_name}','#{date}') ")
    end
    def valid?
        return false if @reference_no.nil? || @customer_name.nil? || @date.nil?
        true
    end
end

def get_all_orders
    rawData = $client.query("select * from orders")
    orders = Array.new
    rawData.each do |data|
        orders.push(data)
    end
    orders
end