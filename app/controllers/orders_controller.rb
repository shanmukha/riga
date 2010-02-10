class OrdersController < ApplicationController

  def new
    @order = Order.new
    @buyer = @order.build_buyer
  end

  def create
    @order = Order.new(params[:order])
    #TODO: find a way to put validaton in model and construct nicer error messages
    if params[:order][:buyer_attributes][:email].blank? || params[:order][:buyer_attributes][:name].blank?
      flash[:error] = 'Please ensure that you have entered name and email address.'
      @buyer = @order.build_buyer
      render :action => "new" 
    else
      if @order.save
        redirect_to(express_checkout_new_order_url(:id => @order.id))  
      else
        @buyer = @order.build_buyer
        render :action => "new"  
      end
    end
    
  end

  def express_checkout
    order = Order.find(params[:id])
    response = EXPRESS_GATEWAY.setup_purchase(1000, :ip => request.remote_ip, :return_url => confirmation_order_url(order), :cancel_return_url => new_order_url)
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end 

  def confirmation
    order = Order.find(params[:id])
    order.update_attributes(:express_token => params[:token], :express_payer_id => params[:PayerID])
    order.buyer.update_attribute('guide_token', order.buyer.make_token)
    GuideSender.deliver_send_guide(order)
  end
end
