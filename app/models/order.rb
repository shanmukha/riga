class Order < ActiveRecord::Base
  require 'digest/sha1'
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

  def secure_digest(*args)
    Digest::SHA1.hexdigest(args.flatten.join('--'))
  end

  def make_token
    secure_digest(Time.now, (1..10).map{ rand.to_s })
  end

end

