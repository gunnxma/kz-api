class CreateUserKlasses < ActiveRecord::Migration
  def change
    create_table :user_klasses do |t|
      t.integer :user_id
      t.integer :klass_id
      t.integer :subject_id

      t.timestamps
    end
  end
end
