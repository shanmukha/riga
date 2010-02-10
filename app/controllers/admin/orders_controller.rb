class Admin::OrdersController < ApplicationController
  layout 'administrator'
  before_filter :require_user

  def index
    @orders = Order.all(:order => 'created_at desc', :include => 'buyer')
  end
end
