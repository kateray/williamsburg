class AddSpecialAttrib < ActiveRecord::Migration
  def change
    add_column :user_pins, :override_neighborhood, :string
  end
end
