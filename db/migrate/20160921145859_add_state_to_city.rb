class AddStateToCity < ActiveRecord::Migration
  def change
    add_column :cities, :state, :string
    add_column :user_pins, :state, :string
  end
end
