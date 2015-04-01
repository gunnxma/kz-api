class CreateUserStatus < ActiveRecord::Migration
  def change
    create_table :user_status do |t|
      t.integer :user_id
      t.integer :status

      t.timestamps
    end
  end
end
