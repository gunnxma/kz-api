class AddUnitIdToOauthApplications < ActiveRecord::Migration
  def change
  	add_column :oauth_applications, :unit_id, :integer
  end
end
