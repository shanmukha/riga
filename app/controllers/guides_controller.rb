class GuidesController < ApplicationController
  def guide
    buyer = Buyer.find_by_guide_token(params[:t])
    unless buyer.blank?
      send_file STAG_GUIDE_PATH
      buyer.update_attribute(:guide_token, '')
    else
      flash[:notice] = "It seems you have already downloaded the guide once."
      redirect_to resend_guide_guides_url
    end
  end

  def resend_guide
  end

  def guide_resent
    buyer = Buyer.find_by_email(params[:email])
    unless buyer.blank?
      buyer.update_attribute('guide_token', buyer.make_token)
      GuideSender.deliver_send_guide(buyer.order)
      flash[:notice] = "Please check your mail. Guide link is resent to your email."
      redirect_to root_url
    else
      flash[:error] = "Entered email is not valid. Re-enter email or please purchase a guide."
      redirect_to resend_guide_guides_url
    end
  end
end
