class Restaurant < ActiveRecord::Base
  validates :name, :address, :city, :state, :zip, presence: true
  validates_format_of :zip,
	  with: /\A\d{5}-\d{4}|\A\d{5}\z/,
	  message: "should be in 12345 or 12345-1234 format",
	  allow_blank: true
	  
  def after_initialize
    if new_record?
      upvote ||= 0
      downvote ||= 0
    end
  end
 
end
