class AddUnitIdToSubjects < ActiveRecord::Migration
  def change
  	add_column :subjects, :unit_id, :integer
  end
end
