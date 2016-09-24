class AddFieldsToPins < ActiveRecord::Migration
  def change
    add_column :user_pins, :used_city, :string
    add_column :user_pins, :used_neighborhood, :string
  end
end
