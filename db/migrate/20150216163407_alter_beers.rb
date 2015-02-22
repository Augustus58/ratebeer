class AlterBeers < ActiveRecord::Migration
  def change
    t=[]
    Beer.all.each { |b| if not t.include?(b.style) then t << b.style end }
    t.each { |style| Style.create name:style, description:style }
    
    change_table :beers do |t|
      t.rename :style, :old_style
      t.integer :style_id
    end

    Beer.all.each do |b|
      b.update("style_id", Style.find_by(name:b.old_style).id) 
    end
    
    change_table :beers do |t|
      t.remove :old_style
    end
  end
end
