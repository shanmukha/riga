class Order < ActiveRecord::Base
  has_one :buyer
  has_one :transaction, :class_name => "OrderTransaction"

  accepts_nested_attributes_for :buyer, :reject_if => proc {|attributes| attributes[:name].blank? or attributes[:email].blank? }

  def purchase
    response = EXPRESS_GATEWAY.purchase(10, :ip => buyer.ip_address, :token => self.express_token, :payer_id => self.express_payer_id)
    #transactions.create!(:action => "purchase", :amount => 10, :response => response)
    OrderTransaction.create!(:action => "purchase",:order_id => self.id, :amount => 10, :response => response)
    response.success?
  end

  def price_in_cents
    (cart.total_price*100).round
  end

end
