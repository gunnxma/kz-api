class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :role_id, :integer
		add_column :users, :email, :string
		add_column :users, :mobile, :string
		add_column :users, :unit_id, :integer
		add_column :users, :gender, :string
		add_column :users, :birthday, :datetime
		add_column :users, :nation_id, :integer
		add_column :users, :department_id, :integer
		add_column :users, :duty_id, :integer
		add_column :users, :logo, :string
		add_column :users, :status, :integer
  end
end
