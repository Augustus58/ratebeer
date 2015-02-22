class AlterBeers < ActiveRecord::Migration
  def change
    t=[]
    Beer.all.each { |b| if not t.include?(Beer.find_by_sql("select style from beers where id = #{b.id}")[0]["style"]) then t << Beer.find_by_sql("select style from beers where id = #{b.id}")[0]["style"] end }
    t.each { |style| Style.create name:style, description:style }
    
    change_table :beers do |t|
      t.rename :style, :old_style
      t.integer :style_id
    end
    byebug
    Beer.all.each do |b|
      b.update_attribute("style_id", Style.find_by(name: b.old_style).id) 
    end
    
    change_table :beers do |t|
      t.remove :old_style
    end
  end
end
