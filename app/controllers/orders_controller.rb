class OrdersController < ApplicationController

  def new
    @order = Order.new
    @buyer = @order.build_buyer
    #We got the transaction id. Now checking the status of the transaction by posting it to PDT.
    resp = pdt_post(params['tx'])
    if resp.body =~ /SUCCESS/
      result = split_response(resp.body)
      @order.payer_id = result['payer_id']
      @buyer.name = result['name']
      @buyer.email = result['email']
      flash.now[:notice] = "Thank you. Your paypal transaction id is #{params['tx']}. Please confirm that, your personal details provided below are correct."
    else
      flash[:error] = "Your transaction id is #{params['tx']}. There was an error, while getting the transaction status. Please contact administrator at email riga_admin@gmail.com and provide your transaction id."
      redirect_to root_url
    end
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
        res = Mechanize.new.post("https://www.sandbox.paypal.com/cgi-bin/webscr", 'cmd' => '_s-xclick', 'hosted_button_id' => '7WFL7WVZAW9RE')
        #redirect_to(express_checkout_new_order_url(:id => @order.id))  
      else
        @buyer = @order.build_buyer
        render :action => "new"  
      end
    end
    
  end

  def express_checkout
    order = Order.find(params[:id])
    response = EXPRESS_GATEWAY.setup_purchase(1000, :ip => request.remote_ip, :return_url => purchase_order_url(order), :cancel_return_url => new_order_url)
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end 

  def purchase
    order = Order.find(params[:id])
    order.update_attributes(:express_token => params[:token], :express_payer_id => params[:PayerID])
    if order.purchase
      redirect_to confirmation_order_url(order)
    else
      flash[:error] = "We couldn't complete your order. Please re-order again. Check your mail once, before re-ordering."
      redirect_to new_order_url
    end
  end

  def confirmation
    order = Order.find(params[:id])
    order.buyer.update_attribute('guide_token', order.buyer.make_token)
    GuideSender.deliver_send_guide(order)
  end

 private
  
  def pdt_post(tx_value)
    Mechanize.new.post("https://www.sandbox.paypal.com/cgi-bin/webscr", 'cmd' => '_notify-synch', 'tx'=> tx_value, 'at' => 'ujtZeP0hhIK9mUKgCC_oc5N0CICy8GpHD9tapxXcXebJbTbELKJWE1RgVLW') 
  end

  def split_response(str_resp)
   result = {}
   result['payer_id'] = str_resp.split('payer_id=')[1].split(' ').first
   result['name'] = 'Vijendra'
   result['email'] = 'e@email.com'
  end
end
