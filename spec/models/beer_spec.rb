require 'rails_helper'

describe Beer do

  it "is not saved without name" do
    beer = Beer.create style:"Extra strong"
    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end
  it "is not saved without style" do
    beer = Beer.create name:"Superbeer"
    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end
  describe "with proper name and style" do
    let(:beer){ Beer.create name:"Superbeer", style:"Extra strong" }
    it "is saved" do
      expect(beer.valid?).to be(true)
      expect(Beer.count).to eq(1)
    end
  end
  
end

#RSpec.describe Beer, :type => :model do
#  pending "add some examples to (or delete) #{__FILE__}"
#end
