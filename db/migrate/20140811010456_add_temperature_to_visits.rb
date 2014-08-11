class AddTemperatureToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :temperature, :decimal, precision: 2
  end
end
