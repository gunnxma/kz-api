class CreateUnitRanks < ActiveRecord::Migration
  def change
    create_table :unit_ranks do |t|
      t.integer :unit_id
      t.integer :rank_id

      t.timestamps
    end
  end
end
