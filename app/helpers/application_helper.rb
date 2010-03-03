# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def find_setting
     @setting = Setting.find(:first)
  end
end

