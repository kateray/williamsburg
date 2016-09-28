class AddQuatCityToPins < ActiveRecord::Migration
  def change
    add_column :user_pins, :quat_city, :string
    add_column :user_pins, :quat_neighborhood, :string
  end
end
