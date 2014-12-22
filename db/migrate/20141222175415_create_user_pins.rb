class CreateUserPins < ActiveRecord::Migration
  def change
    create_table :user_pins do |t|
      t.integer :city_id
      t.string :neighborhood
      t.string :token
      t.float :latitude
      t.float :longitude
      t.timestamps null: false
    end
  end
end
