class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :mark
      t.string :ease_groupid

      t.timestamps
    end
  end
end
