class AddCheckedToPins < ActiveRecord::Migration
  def change
    add_column :user_pins, :checked_quattro, :boolean, default: false
  end
end
