class User < ActiveRecord::Base
  include RatingAverage
  has_secure_password
  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
  validates :password, length: { minimum: 4, maximum: 72}
  validates :password, format: { with: /\d/, message: "have to have at least one digit" }
  validates :password, format: { with: /[A-Z]+/, message: "have to have at least one capital letter" }
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
end
