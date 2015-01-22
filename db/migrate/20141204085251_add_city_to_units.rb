class AddCityToUnits < ActiveRecord::Migration
  def change
  	add_column :units, :province, :string
  	add_column :units, :city, :string
  	add_column :units, :district, :string  	
  end
end
