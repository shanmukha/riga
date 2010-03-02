class Admin::OrdersController < ApplicationController
  layout 'administrator'
  before_filter :require_user

  def index
    @search = Order.ascend_by_created_at.search(params[:search])
    @search.created_at_like = params[:search][:created_at_like].to_date if !params[:search].nil?
    @orders = @search.all(:include => [:buyer, :transaction]).paginate(:page => params[:page], :per_page =>50)
  end
end
