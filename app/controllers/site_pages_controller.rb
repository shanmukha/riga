class SitePagesController < ApplicationController
  caches_page :home, :why_riga, :what_is_in_stag_guide

  def home
  end
  
  def what_is_in_stag_guide
  end
  
  def why_riga
  end

end
