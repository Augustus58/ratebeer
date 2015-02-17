class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
    
    t=[]
    Beer.all.each { |b| if not t.include?(b.style) then t << b.style end }
    t.each { |style| Style.create name:style, description:style }
    
    change_table :beers do |t|
      t.rename :style, :old_style
      t.integer :style_id
    end

    Beer.all.each do |b|
      b.update_attribute :style_id, (Style.find_by name:b.old_style).id 
    end
    
    change_table :beers do |t|
      t.remove :old_style
    end
  end
end
