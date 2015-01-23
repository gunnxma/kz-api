class AddIsChargeToUserKlasses < ActiveRecord::Migration
  def change
    add_column :user_klasses, :is_charge, :integer
  end
end
