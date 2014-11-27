class CreateTeacherKlasses < ActiveRecord::Migration
  def change
    create_table :teacher_klasses do |t|
      t.integer :user_id
      t.integer :klass_id
      t.integer :subject_id
      t.integer :is_charge

      t.timestamps
    end
  end
end
