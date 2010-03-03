class Setting < ActiveRecord::Base

  has_attached_file :setting_pdf,:url  => ":rails_root/guides/:id",
                    :path => ":rails_root/guides/:id/:style/:basename.:extension"

  validates_presence_of :setting_pdf ,:price
  validates_attachment_presence :setting_pdf

  validates_attachment_content_type :setting_pdf, :content_type => ['application/pdf'],
                                     :message => "Make sure you are uploading an pdf file."
end

