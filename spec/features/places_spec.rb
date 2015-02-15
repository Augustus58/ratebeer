require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
                               [ Place.new( name:"Oljenkorsi", id: 1 ) ]
                             )
    
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    
    expect(page).to have_content "Oljenkorsi"
  end
  it "if many is returned by the API, these are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("joensuu").and_return(
                               [ Place.new( name:"Palaveri", id: 1 ),
                                 Place.new( name:"JetSet", id: 2 ),
                                 Place.new( name:"Cafe Fever Pub", id: 3 ) ]
                             )
    visit places_path
    fill_in('city', with: 'joensuu')
    click_button "Search"

    expect(page).to have_content "Palaveri"
    expect(page).to have_content "JetSet"
    expect(page).to have_content "Cafe Fever Pub"
  end
  it "if none is returned by the API, decent message are shown" do
    allow(BeermappingApi).to receive(:places_in).with("nuorgam").and_return(
                               []
                             )
    visit places_path
    fill_in('city', with: 'nuorgam')
    click_button "Search"

    expect(page).to have_content "No locations in nuorgam"
  end
end
