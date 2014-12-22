class CreateAdminPins < ActiveRecord::Migration
  def change
    create_table :admin_pins do |t|
      t.integer :city_id
      t.string :neighborhood
      t.float :latitude
      t.float :longitude
      t.timestamps null: false
    end
  end
end
