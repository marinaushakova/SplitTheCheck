class Restaurant < ActiveRecord::Base
  has_many :votes
  has_many :comments
  has_many :users, :through => :votes
  has_many :users, :through => :comments
  
  validates :name, :address, :city, :state, :zip, presence: true
  validates_format_of :zip,
	  with: /\A\d{5}-\d{4}|\A\d{5}\z/,
	  message: "should be in 12345 or 12345-1234 format",
	  allow_blank: false
end
