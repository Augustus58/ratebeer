module RatingAverage
  def average_rating
    return 0 if self.ratings.empty?
    (self.ratings.map { |r| r.score }.sum / self.ratings.count.to_f)
  end
end
