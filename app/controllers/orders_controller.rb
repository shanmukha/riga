class OrdersController < ApplicationController
  require 'mechanize'
  def new
    @order = Order.new({:payment_type =>"paypal",:transaction_id =>  params[:tx] ,:amount => 10})
    @buyer = @order.build_buyer
    #We got the transaction id. Now checking the status of the transaction by posting it to PDT.
    resp = pdt_post(params[:tx])
    if resp.body =~ /SUCCESS/
      result = split_response(resp.body)
      @order.payer_id = result['payer_id']
      @buyer.name = result['name']
      @buyer.email = result['email']
      flash.now[:notice] = "Thank you. Your paypal transaction id is #{params['tx']}. Please confirm that, your personal details provided below are correct."
      @order.download_token = @order.make_token
      @order.status = 'success'
      @order.save
      redirect_to edit_order_path(@order.id)
    else
      @order.status = 'failure'
      @order.save
      flash[:error] = "Your transaction id is #{params['tx']}. There was an error, while getting the transaction status. Please contact administrator at email riga_admin@gmail.com and provide your transaction id."
      redirect_to root_url
    end
  end


  def edit
    @order = Order.find(params[:id],:include => :buyer)
  end


  def create

    @order = Order.new
     resp = pdt_post(params['tx'])

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
    unless order.download_token.blank?
      order.buyer.update_attribute('guide_token', order.buyer.make_token)
      GuideSender.deliver_send_guide(order)
    end
    order.update_attribute('download_token' , '')
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
       flash[:notice] = 'Order was successfully updated.'
         redirect_to(confirmation_order_path(@order) )
      else
          render :action => "edit"
    end
  end


 private

  def pdt_post(tx_value)
    Mechanize.new.post("https://www.sandbox.paypal.com/cgi-bin/webscr", 'cmd' => '_notify-synch', 'tx'=> tx_value, 'at' => 'ujtZeP0hhIK9mUKgCC_oc5N0CICy8GpHD9tapxXcXebJbTbELKJWE1RgVLW')
  end

  def split_response(str_resp)
   result = {}
   result['payer_id'] = str_resp.split('payer_id=')[1].split(' ').first
     first_name = str_resp.split('first_name=')[1].split(' ').first
     last_name =  str_resp.split('last_name=')[1].split(' ').first
   result['name'] = "#{first_name} #{last_name}"
   result['email'] = str_resp.split('payer_email=')[1].split(' ').first.gsub(/%40/, '@')

   result
  end

end

