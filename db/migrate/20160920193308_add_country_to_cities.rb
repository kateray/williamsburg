class AddCountryToCities < ActiveRecord::Migration
  def change
    add_column :cities, :country, :string
    add_column :user_pins, :country, :string
  end
end
