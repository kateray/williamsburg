class AddFieldsToPoints < ActiveRecord::Migration
  def change
    add_column :cities, :country, :string
    add_column :cities, :state, :string
    add_column :user_pins, :country, :string
    add_column :user_pins, :state, :string
    add_column :user_pins, :city_name, :string
    add_column :user_pins, :suburb, :string
  end
end
