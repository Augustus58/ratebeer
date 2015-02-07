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

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    find_highest_rating_average(calculate_averages(find_ratings_by_styles))
  end

  def favorite_brewery
    return nil if ratings.empty?
    find_highest_rating_average(calculate_averages(find_ratings_by_breweries))
  end
  
  def find_highest_rating_average (averages)
    fs = nil
    max = 0
    averages.each { |key, value|
      if max < value
        max = value
        fs = key
      end
    }
    fs
  end
  
  def find_ratings_by_styles
    ratings.all.group_by { |r| r.beer.style }
  end

  def find_ratings_by_breweries
    ratings.all.group_by { |r| r.beer.brewery }
  end
  
  def calculate_averages h
    averages = Hash.new
    h.each { |key, value| averages[key] = (value.map { |r| r.score }.sum / value.count.to_f).round(2) }
    averages
  end
  
end
