class RemoveKlassIdFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :klass_id
  end
end
