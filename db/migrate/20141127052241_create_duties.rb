class CreateDuties < ActiveRecord::Migration
  def change
    create_table :duties do |t|
      t.integer :unit_id
      t.string :name

      t.timestamps
    end
  end
end
