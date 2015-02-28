class CreateMarkers < ActiveRecord::Migration
  def change
    create_table :markers do |t|
      t.string :marker_type
      t.text :marker_content
      t.string :marker_address
      t.decimal :lat, :precision => 11, :scale => 6
      t.decimal :lng, :precision => 11, :scale => 6
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
