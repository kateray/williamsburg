class AddTownToPins < ActiveRecord::Migration
  def change
    add_column :user_pins, :town, :string
  end
end
