class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  include RatingAverage
  
  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1042,
                                   only_integer: true }
  validate :year_cannot_be_in_the_future

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil, false] }

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| - (b.average_rating || 0) }
    sorted_by_rating_in_desc_order.take(n)
  end
  
  def year_cannot_be_in_the_future
    if self.year > Time.now.year
      errors.add(:year, "can't be in the future")
    end
  end
  
  def restart
    self.year = 2015
    puts "changed year to #{year}"
  end
  
  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end
end
