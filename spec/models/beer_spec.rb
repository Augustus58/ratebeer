require 'rails_helper'

describe Beer do

  it "is not saved without name" do
    style = FactoryGirl.create(:style, name: "Lager", description: "Desc fot lager")
    beer = Beer.create style:style
    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end
  it "is not saved without style" do
    beer = Beer.create name:"Superbeer"
    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end
  describe "with proper name and style" do
    style = FactoryGirl.create(:style, name: "Lager", description: "Desc fot lager")
    let(:beer){ Beer.create name:"Superbeer", style:style }
    it "is saved" do
      expect(beer.valid?).to be(true)
      expect(Beer.count).to eq(1)
    end
  end
  
end

#RSpec.describe Beer, :type => :model do
#  pending "add some examples to (or delete) #{__FILE__}"
#end
