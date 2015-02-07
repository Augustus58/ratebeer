# coding: utf-8
require 'rails_helper'

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating(score, user)
  end
end

describe "Ratings page" do
  let(:user){FactoryGirl.create(:user) }
  
  it "should not have any before been created" do
    visit ratings_path
    expect(page).to have_content 'List of ratings'
    expect(page).to have_content 'Number of ratings: 0'   
  end

  it "should show all existing ratings and number of these" do
    create_beers_with_ratings(10, 20, 15, user)
    visit ratings_path
    expect(page).to have_content 'List of ratings'
    expect(page).to have_content 'Number of ratings: 3'
    Rating.all.each do |rating|
      expect(page).to have_content "#{rating.beer.name} #{rating.score} #{rating.user.username}"
    end
  end
  
end
