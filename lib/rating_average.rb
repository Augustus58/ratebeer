module RatingAverage
  def average_rating
    t = []
    self.ratings.each do |rating|
      t << rating.score
    end
    t.inject { |sum, n| sum + n } / self.ratings.count * 1.0
  end
end
