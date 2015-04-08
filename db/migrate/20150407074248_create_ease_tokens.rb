class CreateEaseTokens < ActiveRecord::Migration
  def change
    create_table :ease_tokens do |t|
      t.string :token
      t.integer :expires_in

      t.timestamps
    end
  end
end
