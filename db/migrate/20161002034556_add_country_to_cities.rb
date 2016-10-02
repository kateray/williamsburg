class AddCountryToCities < ActiveRecord::Migration
  def change
    add_column :cities, :country_code, :string
  end
end
