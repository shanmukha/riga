class Buyer < ActiveRecord::Base
  belongs_to :order
  require 'digest/sha1'
  #before_create :guide_activation_code

  #validates_presence_of :name, :email

  def secure_digest(*args)
    Digest::SHA1.hexdigest(args.flatten.join('--'))
  end

  def make_token
    secure_digest(Time.now, (1..10).map{ rand.to_s })
  end

  def guide_activation_code
    self.guide_token = self.make_token
  end
end
