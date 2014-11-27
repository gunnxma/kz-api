class CreateKlasses < ActiveRecord::Migration
  def change
    create_table :klasses do |t|
      t.integer :unit_id
      t.string :name
      t.integer :year
      t.integer :grade_id
      t.integer :status

      t.timestamps
    end
  end
end
