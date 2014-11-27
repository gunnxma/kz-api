class DeleteSchoolRankIdFromUnits < ActiveRecord::Migration
  def change
  	remove_column :units, :school_rank_id
  end
end
