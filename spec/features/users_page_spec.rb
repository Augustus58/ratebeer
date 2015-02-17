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

def create_beer2_with_rating(score, user, brewery, style)
  beer = FactoryGirl.create(:beer2, brewery:brewery, style:style)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers2_with_ratings(*scores, user, brewery, style)
  scores.each do |score|
    create_beer2_with_rating(score, user, brewery, style)
  end
end

describe "Users page" do
  let!(:user){FactoryGirl.create(:user) }
  let!(:user2){FactoryGirl.create(:user2) }
  let!(:brewery){ FactoryGirl.create(:brewery2) }
  let(:style){ FactoryGirl.create(:style) }
  let(:style2){ FactoryGirl.create(:style2) }
  
  it "should not have any ratings if there's none in the database" do
    visit users_path
    first(:link, 'Show').click
    expect(page).to have_content "#{user.username}"
    expect(page).to have_content 'no ratings yet!'
  end

  it "should show all existing ratings by that user" do
    create_beers_with_ratings(10, 20, 15, user)
    create_beers_with_ratings(11, 21, 16, user2)
    visit users_path
    first(:link, 'Show').click
    expect(page).to have_content user.username
    expect(page).to have_content 'Has made 3 ratings, average 15.0'
    user.ratings.each do |rating|
      expect(page).to have_content "#{rating.beer.name} #{rating.score}"
    end
    user2.ratings.each do |rating|
      expect(page).not_to have_content "#{rating.beer.name} #{rating.score}"
    end
  end

  it "removes rating from database when rating removed" do
    create_beers_with_ratings(10, 20, 15, user)
    create_beers_with_ratings(11, 21, 16, user2)
    sign_in(username:"Pekka", password:"Foobar1")
    visit users_path
    first(:link, 'Show').click
    expect(user.ratings.count).to eq(3)
    expect(Rating.all.count).to eq(6)
    first(:link, 'delete').click
    expect(user.ratings.count).to eq(2)
    expect(Rating.all.count).to eq(5)
  end

  it "shows favorite brewery and favorite style correctly" do
    create_beers_with_ratings(10, 20, 15, 7, 9, user)
    create_beers2_with_ratings(11, 21, 16, 8, 10, user, brewery, style2)
    visit users_path
    first(:link, 'Show').click
    expect(page).to have_content "Favorite brewery: #{user.favorite_brewery.name}"
    expect(page).to have_content "Favorite style: #{user.favorite_style.name}"
  end
  
end
