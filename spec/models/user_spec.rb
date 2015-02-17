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

describe User do
  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end
    
    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)
            
      expect(user.favorite_beer).to eq(best)
    end
    
  end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }
    let(:brewery){ FactoryGirl.create(:brewery2) }
    let(:style){ FactoryGirl.create(:style) }
    let(:style2){ FactoryGirl.create(:style2) }
    
    it "has method for determining one" do
      user.should respond_to :favorite_style
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is that from rating if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)
      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the one with highest rating average if several rated" do
      #Style.all.each { |style| style.destroy }
      create_beers2_with_ratings(10, 20, 15, 7, 9, user, brewery, style)
      create_beers2_with_ratings(11, 21, 16, 8, 10, user, brewery, style2)
      #favorite_style = FactoryGirl.create(:beer2).style      
      expect(user.favorite_style).to eq(style2)
    end
    
  end

  describe "favorite brewery" do
    let(:user){ FactoryGirl.create(:user) }
    let(:brewery){ FactoryGirl.create(:brewery) }
    let(:brewery2){ FactoryGirl.create(:brewery2) }
    let(:style){ FactoryGirl.create(:style) }
    let(:style2){ FactoryGirl.create(:style2) }

    it "has method for determining one" do
      user.should respond_to :favorite_brewery
    end

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is that from rating if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)
      expect(user.favorite_brewery).to eq(beer.brewery)
    end

    it "is the one with highest rating average if several rated" do
      create_beers2_with_ratings(10, 11, 12, 13, user, brewery, style)
      create_beers2_with_ratings(11, 12, 13, 14, user, brewery2, style2)
      expect(user.favorite_brewery).to eq(brewery2)
    end
    
  end
    
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end
  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end
  describe "with a unproper password" do
    let(:user){ User.new username:"Pekka" }

    it "is not saved if password is too short" do
      user.password = "a"
      user.password_confirmation = "a"
      user.save
      expect(user.valid?).to be(false)
      expect(User.count).to eq(0)
    end
    it "or password consists of only letters" do
      user.password = "ehhehee"
      user.password_confirmation = "ehhehee"
      user.save
      expect(user.valid?).to be(false)
      expect(User.count).to eq(0)
    end
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }
    
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)
      
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
end

#RSpec.describe User, :type => :model do
#  pending "add some examples to (or delete) #{__FILE__}"
#end
