class SitePagesController < ApplicationController
  caches_page :home, :why_riga, :what_is_in_stag_guide

  def home
        @order = Order.new
    @buyer = @order.build_buyer
  end

  def what_is_in_stag_guide
  end

  def why_riga
  end

end

