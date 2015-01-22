class AddRankIdToUserSubjects < ActiveRecord::Migration
  def change
  	add_column :user_subjects, :rank_id, :integer
  end
end
