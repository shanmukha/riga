class Order < ActiveRecord::Base
  has_one :buyer
  
  accepts_nested_attributes_for :buyer, :reject_if => proc {|attributes| attributes[:name].blank? or attributes[:email].blank? }
end
