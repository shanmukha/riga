class Admin::OrdersController < ApplicationController
  layout 'administrator'
  before_filter :require_user

  def index
    @search = Order.descend_by_created_at.search(params[:search])
    unless params[:search].blank?
      @search.created_at_like = params[:search][:created_at_like].to_date unless params[:search][:created_at_like].blank?
    end
    @orders = @search.all(:include => [:buyer, :transaction]).paginate(:page => params[:page], :per_page =>50)
  end
end
