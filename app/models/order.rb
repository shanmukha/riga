class Order < ActiveRecord::Base
  has_one :buyer
  has_one :transaction, :class_name => "OrderTransaction"

  accepts_nested_attributes_for :buyer, :reject_if => proc {|attributes| attributes[:name].blank? or attributes[:email].blank? }

  def purchase
    response = EXPRESS_GATEWAY.purchase(1000, :ip => buyer.ip_address, :token => self.express_token, :payer_id => self.express_payer_id)
    self.build_transaction
    transaction.create!(:action => "purchase", :amount => 1000, :response => response)
    response.success?
  end

  def price_in_cents
    (cart.total_price*100).round
  end

end
