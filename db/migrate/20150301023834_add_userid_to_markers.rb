class AddUseridToMarkers < ActiveRecord::Migration
  def change
  	add_column :markers, :user_id, :integer
  	add_index :markers, :user_id
  end
end
