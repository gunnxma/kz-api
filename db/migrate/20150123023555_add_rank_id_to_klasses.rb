class AddRankIdToKlasses < ActiveRecord::Migration
  def change
  	add_column :klasses, :rank_id, :integer
  end
end
