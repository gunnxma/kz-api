class AddKlassIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :klass_id, :integer
  end
end
