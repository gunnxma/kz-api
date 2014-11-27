class DeleteUnitIdFromRoles < ActiveRecord::Migration
  def change
  	remove_column :roles, :unit_id
  end
end
