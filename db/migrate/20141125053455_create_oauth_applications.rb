class CreateOauthApplications < ActiveRecord::Migration
  def change
    create_table :oauth_applications do |t|
      t.string  :name,         null: false
      t.string  :uid,          null: false
      t.string  :secret,       null: false
      t.text    :redirect_uri, null: false

      t.timestamps
    end
    add_index :oauth_applications, :uid, unique: true
  end
end
