# coding: utf-8
require 'rails_helper'

describe "Beers page" do
  it "should not have any before been created" do
    visit beers_path
    expect(page).to have_content 'Listing Beers'
    expect(page).to have_content 'Number of beers: 0'   
  end

  it "allows to add beers when signed in" do
    @breweries = ["Koff", "Karjala", "Schlenkerla"]
    year = 1896
    @breweries.each do |brewery_name|
      FactoryGirl.create(:brewery, name: brewery_name, year: year += 1)
    end
    FactoryGirl.create :user
    sign_in(username:"Pekka", password:"Foobar1")
    visit beers_path
    click_link "New Beer"
    fill_in('beer_name', with:'Superolut')
    select('Lager', from:'beer[style]')
    select('Schlenkerla', from: 'beer[brewery_id]')
    click_button "Create Beer"
    expect(page).to have_content "Beer was successfully created."
    expect(page).to have_content 'Listing Beers'
    expect(page).to have_content "Number of beers: #{Beer.all.count}"
    expect(page).to have_content "Superolut"
  end

  it "works right if bad beer name is given and doesn't save anything to database" do
    @breweries = ["Koff", "Karjala", "Schlenkerla"]
    year = 1896
    @breweries.each do |brewery_name|
      FactoryGirl.create(:brewery, name: brewery_name, year: year += 1)
    end
    FactoryGirl.create :user
    sign_in(username:"Pekka", password:"Foobar1")
    visit beers_path
    click_link "New Beer"
    fill_in('beer_name', with:'')
    select('Lager', from:'beer[style]')
    select('Schlenkerla', from: 'beer[brewery_id]')
    click_button "Create Beer"
    expect(page).to have_content "New Beer"
    expect(page).to have_content "Name can't be blank"
    expect(Beer.count).to eq(0)
  end
 
end
