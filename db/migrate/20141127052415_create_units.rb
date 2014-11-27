class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.integer :unit_type_id
      t.integer :school_rank_id
      t.string :region_code
      t.string :address
      t.string :phone
      t.integer :status

      t.timestamps
    end
  end
end
