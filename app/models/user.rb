class User < ActiveRecord::Base
  has_many :votes
  has_many :comments
  has_many :favorites
  has_many :restaurants, :through => :votes
  has_many :restaurants, :through => :comments
  has_many :restaurants, :through => :favorites
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
