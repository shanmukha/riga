class Admin::OrdersController < ApplicationController
  layout 'administrator'
  before_filter :require_user

  def index
    @search = Order.ascend_by_created_at.search(params[:search])
    @orders = @search.all(:include => [:buyer, :transaction])
  end
end
