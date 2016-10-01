class AddCountryCode < ActiveRecord::Migration
  def change
    add_column :user_pins, :country_code, :string
  end
end
