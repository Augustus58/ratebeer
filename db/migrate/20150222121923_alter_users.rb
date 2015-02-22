class AlterUsers < ActiveRecord::Migration
  def change
    User.all.each do |u|
      u.update_attribute :froze, false
    end
  end
end
