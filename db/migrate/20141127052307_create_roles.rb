class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :unit_id
      t.string :name

      t.timestamps
    end
  end
end
