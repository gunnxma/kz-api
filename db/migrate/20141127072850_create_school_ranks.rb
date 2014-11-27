class CreateSchoolRanks < ActiveRecord::Migration
  def change
    create_table :school_ranks do |t|
      t.integer :unit_id
      t.integer :rank_id

      t.timestamps
    end
  end
end
